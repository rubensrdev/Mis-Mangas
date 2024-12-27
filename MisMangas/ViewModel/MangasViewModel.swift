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
	var page = 1
	var perPage = 50
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var showFilters = false
	
	var selectedManga: Manga?
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	@MainActor
	func loadMangas() async {
		do {
			let response = try await repository.getMangas(page: "\(page)", itemsPerPage: "\(perPage)")
			self.response = response
			mangas = response.items
		} catch {
			showErrorAlert.toggle()
			errorMessage = "Ocurrió un error al cargar los mangas, prueba a refrescar la pantalla"
			print(error)
		}
	}
	
}
