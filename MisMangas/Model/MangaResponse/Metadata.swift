//
//  Metadata.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa la información de paginación devuelta por la API.
///
/// - Propiedades:
///  - `page`: Número de la página actual en la respuesta de la API.
///  - `per`: Cantidad de elementos devueltos por página.
///  - `total`: Número total de elementos disponibles en la consulta.
struct Metadata: Codable {
	let page: Int
	let per: Int
	let total: Int
}
