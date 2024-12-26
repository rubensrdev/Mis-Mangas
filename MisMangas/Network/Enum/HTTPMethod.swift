//
//  HTTPMethod.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Definición de una lista de métodos HTTP comunes que se utilizan para interactuar con API REST
enum HTTPMethod: String {
	/// Para enviar datos al servidor
	case post = "POST"
	/// Para solicitar datos al servidor
	case get = "GET"
	/// Para eliminar datos del servidor
	case delete = "DELETE"
	/// Para actualizar datos existentes
	case put = "PUT"
}

extension HTTPMethod {
	var method: String {
		self.rawValue
	}
}
