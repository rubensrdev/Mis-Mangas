//
//  Author.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct Author: Codable, Identifiable, Hashable {
	let id: UUID
	let role: String
	let firstName: String
	let lastName: String
}

extension Author {
	var fullName: String {
		"\(firstName) \(lastName)"
	}
}
