//
//  NetworkInteractor.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Protocolo que define las interacciones básicas para realizar solicitudes de red.
///
/// - Requisitos:
///   - `session`: Una instancia de `URLSession` que se utiliza para realizar las solicitudes HTTP.
protocol NetworkInteractor {
	var session: URLSession { get }
}

extension NetworkInteractor {
	/// Ejecuta una solicitud HTTP y decodifica la respuesta en un tipo específico.
	///
	/// - Parámetros:
	///   - `request`: La solicitud `URLRequest` configurada que se desea ejecutar.
	///   - `type`: El tipo `Codable` al que se desea decodificar la respuesta JSON.
	/// - Retorno: Un objeto decodificado del tipo especificado (`JSON`).
	/// - Errores:
	///   - `NetworkError.status`: Si el código de estado HTTP no es `200`.
	///   - `NetworkError.json`: Si falla la decodificación del JSON.
	///   - Otros errores relacionados con la red encapsulados en `NetworkError`.
	func executeRequest<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
		let (data, response) = try await session.getData(from: request)
		if response.statusCode == 200 {
			do {
				return try JSONDecoder().decode(JSON.self, from: data)
			} catch {
				throw NetworkError.json(error)
			}
		} else {
			throw NetworkError.status(response.statusCode)
		}
	}
}
