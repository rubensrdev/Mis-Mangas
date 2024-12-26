//
//  URL.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// URL base para las solicitudes del API
let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/")!

extension URL {
	/// Construye una URL para obtener la lista de mangas paginada.
	///
	/// - Parameter page: El número de la página a consultar.
	/// - Returns: Una URL configurada para la solicitud de mangas.
	static func mangas(page: String) -> URL {
		mainURL
			.appending(path: Endpoints.mangas.path)
			.appending(queryItems: [.queryPage(page: page)])
	}
}

extension URLQueryItem {
	/// Crea un parámetro de consulta para la paginación.
	///
	/// - Parameter page: El número de la página a consultar.
	/// - Returns: Un objeto `URLQueryItem` con el nombre "page" y el valor correspondiente.
	static func queryPage(page: String) -> URLQueryItem {
		URLQueryItem(name: "page", value: page)
	}
}
