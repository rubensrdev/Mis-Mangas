//
//  RepositoryRemotePreview.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

struct RepositoryRemotePreview: NetworkInteractor, RepositoryRemoteProtocol {
	let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	func getMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "mangasPreview", withExtension: "json")!)
		print("Getting mangas preview")
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}
}
