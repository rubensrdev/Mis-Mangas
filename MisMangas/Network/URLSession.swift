//
//  URLSession.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

extension URLSession {
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
