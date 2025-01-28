//
//  CustomSearch.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

/// Representa los criterios de búsqueda para realizar consultas personalizadas en la API.
///
/// - Propiedades:
///  - `searchTitle`: Título del manga a buscar. Es opcional.
///  - `searchAuthorFirstName`: Primer nombre del autor a buscar. Es opcional.
///  - `searchAuthorLastName`: Apellido del autor a buscar. Es opcional.
///  - `searchGenres`: Lista de géneros a incluir en la búsqueda. Es opcional.
///  - `searchThemes`: Lista de temáticas a incluir en la búsqueda. Es opcional.
///  - `searchDemographics`: Lista de demografías a incluir en la búsqueda. Es opcional.
///  - `searchContains`: Indica el modo de búsqueda.
///  - `page`: Número de página para la paginación de resultados.
///  - `perPage`: Número de resultados por página.
struct CustomSearch: Codable {
	let searchTitle: String?
	let searchAuthorFirstName: String?
	let searchAuthorLastName: String?
	let searchGenres: [String]?
	let searchThemes: [String]?
	let searchDemographics: [String]?
	let searchContains: Bool
	var page: String
	var perPage: String
}
