//
//  RepositoryRemote.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct RepositoryRemote: RepositoryRemoteProtocol, NetworkInteractor {
	let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func getMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(
					request: .get(.mangas(page: page, itemsPerPage: itemsPerPage)),
					type: PaginatedMangaResponse.self)
	}
	
	func searchMangas(with searchCriteria: CustomSearch) async throws -> PaginatedMangaResponse {
		let request = try URLRequest.post(URL.searchMangas(page: searchCriteria.page, itemsPerPage: searchCriteria.perPage), body: searchCriteria)
		return try await executeRequest(request: request, type: PaginatedMangaResponse.self)
	}
}
