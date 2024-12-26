//
//  Endpoints.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa los endpoints disponibles para interactuar con la API.
enum Endpoints: String {
	case mangas = "mangas"
}

extension Endpoints {
	/// retorna el valor asociado al caso de forma más legible
	var path: String {
		self.rawValue
	}
}
