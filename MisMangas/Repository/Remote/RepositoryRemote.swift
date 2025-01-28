//
//  RepositoryRemote.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation


/// Implementación del repositorio remoto para interactuar con el API de mangas.
///
/// - Conformidades:
///   - `RepositoryRemoteProtocol`: Proporciona las funcionalidades definidas para interactuar con el repositorio remoto.
///   - `NetworkInteractor`: Permite ejecutar solicitudes HTTP de manera genérica.
///
/// - Propiedades:
///   - `session`: Instancia de `URLSession` utilizada para realizar solicitudes de red.
struct RepositoryRemote: RepositoryRemoteProtocol, NetworkInteractor {
	
	let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
	
	/// Obtiene una lista paginada de mangas.
	func getMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(
					request: .get(.mangas(page: page, itemsPerPage: itemsPerPage)),
					type: PaginatedMangaResponse.self)
	}
	
	/// Obtiene una lista paginada de mangas filtrados por temática.
	func getMangasByThemes(_ theme: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(request: .get(.mangasByThemes(theme, page: page, itemsPerPage: itemsPerPage)), type: PaginatedMangaResponse.self)
	}
	
	/// Obtiene una lista paginada de mangas filtrados por género.
	func getMangasByGenres(_ genre: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(request: .get(.mangasByGenres(genre, page: page, itemsPerPage: itemsPerPage)), type: PaginatedMangaResponse.self)
	}
	
	/// Obtiene una lista paginada de mangas filtrados por demografía.
	func getMangasByDemographic(_ demographic: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(request: .get(.mangasByDemographic(demographic, page: page, itemsPerPage: itemsPerPage)), type: PaginatedMangaResponse.self)
	}
	
	/// Obtiene una lista paginada de los mangas mejor valorados.
	func getBestMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse {
		try await executeRequest(request: .get(.bestMangas(page: page, itemsPerPage: itemsPerPage)), type: PaginatedMangaResponse.self)
	}
	
	/// Obtiene una lista de autores disponibles.
	func getAuthors() async throws -> [Author] {
		try await executeRequest(request: .get(.authors()), type: [Author].self)
	}
	
	/// Obtiene una lista de demografías disponibles.
	func getDemographics() async throws -> [String] {
		try await executeRequest(request: .get(.demographics()), type: [String].self)
	}
	
	/// Obtiene una lista de temáticas disponibles.
	func getThemes() async throws -> [String] {
		try await executeRequest(request: .get(.themes()), type: [String].self)
	}
	
	/// Obtiene una lista de géneros disponibles.
	func getGenres() async throws -> [String] {
		try await executeRequest(request: .get(.genres()), type: [String].self)
	}
	
	/// Realiza una búsqueda avanzada de mangas basada en criterios personalizados.
	///
	/// - Parámetro `searchCriteria`: Un objeto `CustomSearch` que define los criterios de búsqueda.
	/// - Retorno: Un objeto `PaginatedMangaResponse` con los resultados de la búsqueda.
	func searchMangas(with searchCriteria: CustomSearch) async throws -> PaginatedMangaResponse {
		let request = try URLRequest.post(URL.searchMangas(page: searchCriteria.page, itemsPerPage: searchCriteria.perPage), body: searchCriteria)
		return try await executeRequest(request: request, type: PaginatedMangaResponse.self)
	}
}
