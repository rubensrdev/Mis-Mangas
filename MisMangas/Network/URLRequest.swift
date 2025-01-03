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
	
	static func post<BODY>(_ url: URL, body: BODY) -> URLRequest where BODY: Encodable {
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.method
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		request.httpBody = try? JSONEncoder().encode(body)
		return request
	}
	
}
