//
//  Genre.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

/// Representa un género asociado a un manga.
///
/// - Propiedades:
///  - `id`: Identificador único del género en formato `UUID`.
///  - `genre`: Nombre del género como una cadena de texto.
struct Genre: Codable, Hashable {
	let id: UUID
	let genre: String
}
