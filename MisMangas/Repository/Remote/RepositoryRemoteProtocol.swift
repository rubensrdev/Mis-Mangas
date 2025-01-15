//
//  RepositoryRemoteProtocol.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

protocol RepositoryRemoteProtocol: Sendable {
	func getMangas(page: String, itemsPerPage: String) async throws-> PaginatedMangaResponse
	func getBestMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getAuthors() async throws -> [Author]
	func getDemographics(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getThemes(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getGenres(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func searchMangas(with searchCriteria: CustomSearch) async throws -> PaginatedMangaResponse
}
