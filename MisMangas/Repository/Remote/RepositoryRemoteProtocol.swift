//
//  RepositoryRemoteProtocol.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Protocolo que define las operaciones necesarias para interactuar con un repositorio remoto de mangas.
///
/// - Conformidades:
///   - `Sendable`: Permite que las implementaciones sean utilizadas en entornos concurrentes de forma segura.
///
/// - Métodos:
///   - Operaciones para obtener datos paginados, filtrados o específicos de mangas, autores, demografías, temáticas y géneros.
///   - Método para realizar búsquedas avanzadas con criterios personalizados.
protocol RepositoryRemoteProtocol: Sendable {
	func getMangas(page: String, itemsPerPage: String) async throws-> PaginatedMangaResponse
	func getMangasByThemes(_ theme: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getMangasByGenres(_ genre: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getMangasByDemographic(_ demographic: String, page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getBestMangas(page: String, itemsPerPage: String) async throws -> PaginatedMangaResponse
	func getAuthors() async throws -> [Author]
	func getDemographics() async throws -> [String]
	func getThemes() async throws -> [String]
	func getGenres() async throws -> [String]
	func searchMangas(with searchCriteria: CustomSearch) async throws -> PaginatedMangaResponse
}
