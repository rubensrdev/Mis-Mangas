//
//  Author.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa un autor asociado a un manga.
///
/// - Propiedades:
///  - `id`: Identificador único del autor en formato `UUID`.
///  - `role`: Rol del autor en la creación del manga.
///  - `firstName`: Primer nombre del autor.
///  - `lastName`: Apellido del autor.
struct Author: Codable, Identifiable, Hashable {
	let id: UUID
	let role: String
	let firstName: String
	let lastName: String
}

extension Author {
	/// Nombre completo del autor. Es una cadena que combina el primer nombre y el apellido.
	var fullName: String {
		"\(firstName) \(lastName)"
	}
}
