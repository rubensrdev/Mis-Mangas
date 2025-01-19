//
//  ExploreViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 14/1/25.
//

import Foundation

@Observable
final class ExploreViewModel {
	let repository: RepositoryRemoteProtocol
	
	var mangas: [Manga] = []
	var authors: [Author] = []
	var demographics: [String] = []
	var genres: [String] = []
	var themes: [String] = []
	
	let perPage = 100
	var page = 1
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var allAuthors: [Author] = [] // Lista completa de autores cargados desde el servidor
	var authorSimulatedPerPage = 40
	var authorSimulatedPage = 1
	var totalAuthors = 0
	var isLoadingMoreAuthors = false
	
	var selectedExploreOption: ExploreOptions = .bestMangas
	
	private var totalItems = 0
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	@MainActor
	func loadAuthors() async {
		guard allAuthors.isEmpty else { return }
		do {
			let response = try await repository.getAuthors()
			allAuthors = response
			authors = Array(allAuthors.prefix(perPage))
			totalAuthors = allAuthors.count
		} catch {
			errorMessage = "Error loading authors"
			showErrorAlert.toggle()
		}
	}
	
	@MainActor
	func checkAndLoadMoreAuthors(current: Author) {
		guard current == authors.last else { return }
		loadMoreAuthors()
	}
	
	@MainActor
	func loadMoreAuthors() {
		guard !isLoadingMoreAuthors, authors.count < totalAuthors else { return }
		isLoadingMoreAuthors = true
		let currentCount = authors.count
		let newCount = min(currentCount + perPage, totalAuthors)
		authors = Array(allAuthors.prefix(newCount))
		isLoadingMoreAuthors = false
	}
	
	func changeSelectedOption(to option: ExploreOptions) {
		selectedExploreOption = option
	}
	
	@MainActor
	func loadMangasForSelectedOption() async {
		do {
			switch selectedExploreOption {
				case .bestMangas:
					let response = try await repository.getBestMangas(page: "\(page)", itemsPerPage: "\(perPage)")
					let filteredMangas = response.items.filter { manga in
						!mangas.contains { $0.id == manga.id }
					}
					mangas.append(contentsOf: filteredMangas)
					totalItems = response.metadata.total
				case .authors:
					if allAuthors.isEmpty {
						await loadAuthors()
					}
				case .demographics:
					let response = try await repository.getDemographics()
					guard !response.isEmpty else { return }
					let filteredDemographics = response.filter { demographic in
						!demographics.contains(demographic)
					}
					demographics.append(contentsOf: filteredDemographics)
				case .genres:
					let response = try await repository.getGenres()
					guard !response.isEmpty else { return }
					let filteredGenres = response.filter { genre in
						!genres.contains(genre)
					}
					genres.append(contentsOf: filteredGenres)
				case .themes:
					let response = try await repository.getThemes()
					guard !response.isEmpty else { return }
					let filteredThemes = response.filter { theme in
						!themes.contains(theme)
					}
					themes.append(contentsOf: filteredThemes)
			}
		} catch let error as NetworkError {
			errorMessage = error.errorDescription ?? "Ocurrió un error inesperado en la red, prueba a refrescar la pantalla"
			showErrorAlert.toggle()
			print(error)
		} catch {
			errorMessage = "Ocurrió un error al cargar los mangas, prueba a refrescar la pantalla"
			showErrorAlert.toggle()
			print(error)
		}
	}
	
}
