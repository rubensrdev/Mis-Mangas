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
	
	var responseForMangas: PaginatedMangaResponse?
	var mangas: [Manga] = []
	var responseForAuthors: [Author]?
	var authors: [Author] = []
	
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
					responseForMangas = response
					let filteredMangas = response.items.filter { manga in
						!mangas.contains { $0.id == manga.id }
					}
					mangas.append(contentsOf: filteredMangas)
					totalItems = response.metadata.total
				case .authors:
					let response = try await repository.getAuthors()
					responseForAuthors = response
					let filteredAuthors = response.filter { author in
						!authors.contains { $0.id == author.id }
					}
					authors.append(contentsOf: filteredAuthors)
				default:
					print("Default case")
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
