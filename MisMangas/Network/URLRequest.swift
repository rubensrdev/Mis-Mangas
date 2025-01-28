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
	/// - Parámetro:
	///   - `url`: La URL a la que se dirigirá la solicitud.
	/// - Retorno: Una instancia de `URLRequest` configurada para realizar una solicitud GET.
	/// - Configuración:
	///   - Método HTTP: `GET`.
	///   - Cabecera HTTP: `"Accept": "application/json"`.
	static func get(_ url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.get.method
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
	
	/// Crea y configura una solicitud HTTP POST con un cuerpo codificado en JSON.
	///
	/// - Parámetros:
	///   - `url`: La URL a la que se dirigirá la solicitud.
	///   - `body`: El cuerpo de la solicitud, que debe conformar a `Encodable`.
	/// - Retorno: Una instancia de `URLRequest` configurada para realizar una solicitud POST con el cuerpo codificado.
	/// - Errores:
	///   - Lanza `NetworkError.json` si falla la codificación del cuerpo.
	/// - Configuración:
	///   - Método HTTP: `POST`.
	///   - Cabecera HTTP: `"Content-Type": "application/json"`.
	///   - Codificación del cuerpo: JSON.
	static func post<BODY>(_ url: URL, body: BODY) throws(NetworkError) -> URLRequest where BODY: Encodable {
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.method
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		do {
			request.httpBody = try JSONEncoder().encode(body)
		} catch {
			throw NetworkError.json(error)
		}
		return request
	}
	
}
