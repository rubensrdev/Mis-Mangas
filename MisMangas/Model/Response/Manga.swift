//
//  Manga.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct Manga: Codable, Identifiable {
	let id: Int
	let title: String
	let titleJapanese: String
	let titleEnglish: String?
	let background: String?
	let mainPicture: String?
	let synopsis: String?
	let startDate: String
	let endDate: String?
	let score: Double
	let status: String
	let chapters: Int?
	let volumes: Int?
	let url: String?
	let authors: [Author]
	let genres: [Genre]
	let themes: [Theme]
	let demographics: [Demographic]
}

extension Manga {
	var imageURL: URL? {
		guard let mainPicture else { return nil }
		// Limpieza inicial: eliminar comillas y caracteres escapados
		var cleanedURLString = mainPicture
			.trimmingCharacters(in: .init(charactersIn: "\"")) // Elimina comillas adicionales
			.replacingOccurrences(of: "\\/", with: "/") // Reemplaza barras escapadas
		// Validación del esquema: asegurarse de que la URL tenga "https://"
		if !cleanedURLString.hasPrefix("https://") && !cleanedURLString.hasPrefix("http://") {
			cleanedURLString = "https://\(cleanedURLString)"
		}
		// Escapado de caracteres especiales
		cleanedURLString = cleanedURLString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? cleanedURLString
		// Validación adicional: longitud mínima de la URL y formato correcto
		guard let url = URL(string: cleanedURLString),
			  url.host != nil, // Asegurarse de que tenga un host válido
			  url.scheme != nil else { // Verificar que tenga un esquema (https o http)
			return nil
		}
		return url
	}
}
