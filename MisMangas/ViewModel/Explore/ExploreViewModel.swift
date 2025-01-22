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
	
	var mangasForOption: [Manga] = []
	var isLoadingMangasForOption = false
	var pageForOption = 1
	var perPageForOption = 40
	var totalItemsForOption = 0
	
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
			showErrorAlert = true
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
	func loadForSelectedOption() async {
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
			errorMessage = error.errorDescription ?? "An unexpected network error occurred, try refreshing the screen"
			showErrorAlert = true
			print(error)
		} catch {
			errorMessage = "An error occurred while loading the manga, try refreshing the screen"
			showErrorAlert = true
			print(error)
		}
	}
	
	@MainActor
	func searchMangasFor(_ option: ExploreOptions, _ selected: String, _ page: String, _ perPage: String) async throws -> PaginatedMangaResponse? {
		do {
			switch option {
				case .demographics:
					return try await repository.getMangasByDemographic(selected, page: page, itemsPerPage: perPage)
				case .genres:
					return try await repository.getMangasByGenres(selected, page: page, itemsPerPage: perPage)
				case .themes:
					return try await repository.getMangasByThemes(selected, page: page, itemsPerPage: perPage)
				default:
					return nil
			}
		} catch {
			errorMessage = "Failed to load mangas for \(selected) in \(option.rawValue)"
			showErrorAlert = true
			return nil
		}
	}
	
	func resetStateForOption() {
		mangasForOption.removeAll()
		isLoadingMangasForOption = false
		pageForOption = 1
		totalItemsForOption = 0
	}

	@MainActor
	func loadMangasForSelectedOption(_ option: ExploreOptions, selected: String) async {
		if pageForOption == 1 {
			resetStateForOption()
		}
		guard !isLoadingMangasForOption else { return }
		isLoadingMangasForOption = true
		do {
			let response = try await searchMangasFor(option, selected, "\(pageForOption)", "\(perPageForOption)")
			if let response = response {
				let mangas = response.items.filter { manga in
					!mangasForOption.contains { $0.id == manga.id }
				}
				mangasForOption.append(contentsOf: mangas)
				totalItemsForOption = response.metadata.total
				pageForOption += 1
			}
		} catch {
			errorMessage = "Failed to load mangas for \(selected) in \(option.rawValue)"
			showErrorAlert = true
		}
		isLoadingMangasForOption = false
	}
	
	private func hasMorePages() -> Bool {
		mangasForOption.count < totalItemsForOption
	}
	
	@MainActor
	func loadMoreMangasIfNeeded(for id: Int, _ option: ExploreOptions, _ selected: String) async {
		guard !isLoadingMangasForOption, mangasForOption.last?.id == id, mangasForOption.count < totalItemsForOption, hasMorePages() else { return }
		await loadMangasForSelectedOption(option, selected: selected)
	}
	
}
