//
//  Author.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct Author: Codable, Identifiable {
	let id: UUID
	let role: String
	let firstName: String
	let lastName: String
}

extension Author {
	func toDTO() -> AuthorDTO {
		AuthorDTO(id: id, role: role, firstName: firstName, lastName: lastName)
	}
}
