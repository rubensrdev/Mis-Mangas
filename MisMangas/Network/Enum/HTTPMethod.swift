//
//  HTTPMethod.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation


/// Enumeración que define los métodos HTTP comunes utilizados en solicitudes a la API.
///
/// - Casos:
///  - `post`: Método HTTP para enviar datos al servidor.
///  - `get`: Método HTTP para recuperar datos del servidor.
///  - `delete`: Método HTTP para eliminar datos en el servidor.
///  - `put`: Método HTTP para actualizar datos existentes en el servidor.
enum HTTPMethod: String {
	case post = "POST"
	case get = "GET"
	case delete = "DELETE"
	case put = "PUT"
}

extension HTTPMethod {
	/// Devuelve el valor asociado al caso de forma más legible
	var method: String {
		self.rawValue
	}
}
