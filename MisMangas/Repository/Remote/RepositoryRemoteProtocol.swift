//
//  RepositoryRemoteProtocol.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

protocol RepositoryRemoteProtocol: Sendable {
	func getMangas(page: String, itemsPerPage: String) async throws-> PaginatedMangaResponse
}
