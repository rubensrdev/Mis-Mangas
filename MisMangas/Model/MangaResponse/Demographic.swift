//
//  Demographic.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

/// Representa una demografía asociada a un manga.
///
/// - Propiedades:
///  - `id`: Identificador único de la demografía en formato `UUID`.
///  - `demographic`: Nombre de la demografía como una cadena de texto.
struct Demographic: Codable, Hashable {
	let id: UUID
	let demographic: String
}
