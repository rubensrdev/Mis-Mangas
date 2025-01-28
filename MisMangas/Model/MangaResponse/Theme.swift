//
//  Theme.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation


/// Representa una temática asociada a un manga.
///
/// - Propiedades:
///  - `id`: Identificador único de la temática en formato `UUID`.
///  - `theme`: Nombre de la temática como una cadena de texto.
struct Theme: Codable, Hashable {
	let id: UUID
	let theme: String
}
