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
	var mangas: [Manga] = []
	
	let perPage = 12
	var page = 1
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var showFilters = false
	
	var selectedManga: Manga?
	
	private var isLoadingMore = false
	private var totalItems = 0
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	@MainActor
	func loadMangas() async {
		do {
			let response = try await repository.getMangas(page: "\(page)", itemsPerPage: "\(perPage)")
			self.response = response
			mangas.append(contentsOf: response.items)
			totalItems = response.metadata.total
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
		guard isLast(id: id),
			  hasMorePages(),
			  !isLoadingMore else { return }
		isLoadingMore = true
		page += 1
		Task {
			await loadMangas()
			isLoadingMore = false
		}
	}
	
	
}
