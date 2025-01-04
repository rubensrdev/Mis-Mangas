//
//  MangasVM.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

@Observable
final class MangasViewModel {
	let repository: RepositoryRemoteProtocol
	
	var response: PaginatedMangaResponse?
	var mangas: [Manga] = [] // TODO: revisar cambio a SET para evitar duplicados
	
	let perPage = 12
	var page = 1
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var showFilters = false
	
	var selectedManga: Manga?
	
	var isLoadingMore = false
	
	private var totalItems = 0
	
	var isSearching = false
	var searchCriteria: CustomSearch?
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	@MainActor
	func loadMangas() async {
		do {
			if isSearching, var searchCriteria = searchCriteria {
				if page == 1 {
					mangas.removeAll()
				}
				searchCriteria.page = "\(page)"
				searchCriteria.perPage = "\(perPage)"
				let response = try await repository.searchMangas(with: searchCriteria)
				self.response = response
				let filteredMangas = response.items.filter { manga in
					!mangas.contains { $0.id == manga.id }
				}
				mangas.append(contentsOf: filteredMangas)
				totalItems = response.metadata.total
			} else {
				let response = try await repository.getMangas(page: "\(page)", itemsPerPage: "\(perPage)")
				self.response = response
				let filteredMangas = response.items.filter { manga in
					!mangas.contains { $0.id == manga.id }
				}
				mangas.append(contentsOf: filteredMangas)
				totalItems = response.metadata.total
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
	
	private func isLast(id: Int) -> Bool {
		mangas.last?.id == id
	}
	
	private func hasMorePages() -> Bool {
		mangas.count < totalItems
	}
	
	@MainActor
	func loadMoreMangas(id: Int) {
		guard isLast(id: id), hasMorePages(), !isLoadingMore else { return }
		isLoadingMore = true
		page += 1
		Task {
			await loadMangas()
			isLoadingMore = false
		}
	}
	
	private func startSearch(with criteria: CustomSearch) {
		searchCriteria = criteria
		isSearching = true
		page = 1
	}
	
	@MainActor
	func search(with criteria: CustomSearch) async {
		startSearch(with: criteria)
		await self.loadMangas()
	}
	
	func resetSearch() {
		searchCriteria = nil
		isSearching = false
		page = 1
		mangas.removeAll()
	}
	
}
