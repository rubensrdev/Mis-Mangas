//
//  URLSession.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

extension URLSession {
	/// Realiza una solicitud HTTP y devuelve los datos y la respuesta HTTP.
	///
	/// - Parámetros:
	///   - `request`: La solicitud `URLRequest` que se desea ejecutar.
	/// - Retorno:
	///   - Una tupla que contiene los datos (`Data`) y la respuesta HTTP (`HTTPURLResponse`).
	/// - Errores:
	///   - `NetworkError.nonHttp`: Si la respuesta no es una respuesta HTTP válida.
	///   - `NetworkError.unknown`: Si ocurre un error desconocido durante la solicitud.
	func getData(from request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await data(for: request)
			guard let httpResponse = response as? HTTPURLResponse else {
				throw NetworkError.nonHttp
			}
			return (data, httpResponse)
		} catch let error as NetworkError {
			throw error
		} catch let error {
			throw NetworkError.unknown(error)
		}
	}
	
	/// Realiza una solicitud HTTP POST y devuelve los datos y la respuesta HTTP.
	///
	/// - Parámetros:
	///   - `request`: La solicitud `URLRequest` configurada para realizar una solicitud POST.
	/// - Retorno:
	///   - Una tupla que contiene los datos (`Data`) y la respuesta HTTP (`HTTPURLResponse`).
	/// - Errores:
	///   - `NetworkError.nonHttp`: Si la respuesta no es una respuesta HTTP válida.
	///   - `NetworkError.unknown`: Si ocurre un error desconocido durante la solicitud.
	func postData(from request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await data(for: request)
			guard let httpResponse = response as? HTTPURLResponse else {
				throw NetworkError.nonHttp
			}
			return (data, httpResponse)
		} catch let error as NetworkError {
			throw error
		} catch let error {
			throw NetworkError.unknown(error)
		}
	}
}
