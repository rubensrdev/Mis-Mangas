//
//  PaginatedMangaResponse.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa una respuesta paginada del API que contiene información sobre mangas y metadatos de la consulta.
///
/// - Propiedades:
///  - `metadata`: Metadatos de la paginación, que incluyen información como la página actual,
///    el número de elementos por página y el total de elementos disponibles.
///  - `items`: Lista de mangas devueltos en la respuesta para la página actual.
struct PaginatedMangaResponse: Codable {
	let metadata: Metadata
	let items: [Manga]
}
