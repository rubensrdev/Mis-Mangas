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
	
	let perPage = 12
	var page = 1
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var isLoadingMore = false
	
	var selectedExploreOption: ExploreOptions = .bestMangas
	
	private var totalItems = 0
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
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
					let response = try await repository.getAuthors()
					let filteredAuthors = response.filter { author in
						!authors.contains { $0.id == author.id }
					}
					authors.append(contentsOf: filteredAuthors)
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
			showErrorAlert.toggle()
			errorMessage = error.errorDescription ?? "Ocurrió un error inesperado en la red, prueba a refrescar la pantalla"
			print(error)
		} catch {
			showErrorAlert.toggle()
			errorMessage = "Ocurrió un error al cargar los mangas, prueba a refrescar la pantalla"
			print(error)
		}
	}
	
}
