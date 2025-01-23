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
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}

	func getMangasByThemes(_ theme: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "mangasByThemePreview", withExtension: "json")!)
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}

	func getMangasByGenres(_ genre: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "mangasByGenrePreview", withExtension: "json")!)
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}
	
	func getMangasByDemographic(_ demographic: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "mangasByDemographyPreview", withExtension: "json")!)
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}
	
	func getBestMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "bestMangasPreview", withExtension: "json")!)
		return try JSONDecoder().decode(PaginatedMangaResponse.self, from: data)
	}
	
	func getAuthors() async throws -> [Author] {
		let data = try Data(contentsOf: Bundle.main.url(forResource: "authorsPreview", withExtension: "json")!)
		return try JSONDecoder().decode([Author].self, from: data)
	}
	
	func getDemographics() async throws -> [String] {
		previewDemographics
	}
	
	func getThemes() async throws -> [String] {
		previewThemes
	}
	
	func getGenres() async throws -> [String] {
		previewGenres
	}
	
	// TODO: Cambiar por otro fichero de resultado para diferenciar en la preview
	func searchMangas(with searchCriteria: CustomSearch) async throws -> PaginatedMangaResponse {
		try await self.getMangas(page: "1", itemsPerPage: "10")
	}
	
}
