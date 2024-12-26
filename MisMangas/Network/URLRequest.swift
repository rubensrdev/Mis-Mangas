//
//  URLRequest.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

extension URLRequest {
	/// Crea y configura una solicitud HTTP GET.
	///
	/// - Parameter url: La URL a la que se dirigirá la solicitud.
	/// - Returns: Una instancia de `URLRequest` configurada para realizar una solicitud GET.
	/// - Configuración:
	///   - Método HTTP: GET.
	///   - Cabecera HTTP: `"Accept": "application/json"`.
	static func get(_ url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.get.method
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
}
