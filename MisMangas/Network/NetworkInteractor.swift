//
//  NetworkInteractor.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

protocol NetworkInteractor {
	var session: URLSession { get }
}

extension NetworkInteractor {
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
