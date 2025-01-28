//
//  Manga.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa un manga con todos los detalles necesarios para su presentación y gestión en la app.
///
/// - Propiedades:
///  - `id`: Identificador único del manga.
///  - `title`: Título principal del manga.
///  - `titleJapanese`: Título del manga en japonés (opcional).
///  - `titleEnglish`: Título del manga en inglés (opcional).
///  - `background`: Información de contexto o historia del manga (opcional).
///  - `mainPicture`: URL de la imagen principal del manga (opcional).
///  - `sypnosis`: Sinopsis del manga (opcional).
///  - `startDate`: Fecha de inicio de publicación en formato ISO8601 (opcional).
///  - `endDate`: Fecha de finalización de publicación en formato ISO8601 (opcional).
///  - `score`: Puntuación del manga, basada en valoraciones (de 0.0 a 10.0).
///  - `status`: Estado actual del manga (por ejemplo, "Finished", "Ongoing").
///  - `chapters`: Número total de capítulos del manga (opcional).
///  - `volumes`: Número total de volúmenes del manga (opcional).
///  - `url`: URL con más detalles del manga (opcional).
///  - `authors`: Lista de autores asociados al manga.
///  - `genres`: Lista de géneros asociados al manga.
///  - `themes`: Lista de temáticas asociadas al manga.
///  - `demographics`: Lista de demografías objetivo del manga.
struct Manga: Codable, Identifiable, Hashable {
	let id: Int
	let title: String
	let titleJapanese: String?
	let titleEnglish: String?
	let background: String?
	let mainPicture: String?
	let sypnosis: String?
	let startDate: String?
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
	/// URL limpia y válida para la imagen principal del manga.
	var imageURL: URL? {
		guard let mainPicture else { return nil }
		var cleanedURLString = mainPicture
			.trimmingCharacters(in: .init(charactersIn: "\""))
			.replacingOccurrences(of: "\\/", with: "/")
		if !cleanedURLString.hasPrefix("https://") && !cleanedURLString.hasPrefix("http://") {
			cleanedURLString = "https://\(cleanedURLString)"
		}
		cleanedURLString = cleanedURLString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? cleanedURLString
		guard let url = URL(string: cleanedURLString),
			  url.host != nil,
			  url.scheme != nil else {
			return nil
		}
		return url
	}
	
	/// Formatea la puntuación del manga con un decimal.
	var scoreFormatted: String {
		score.formatted(.number.precision(.fractionLength(1)))
	}
	
	/// Devuelve el estado del manga como un caso del enum `StatusCases`.
	var statusFormatted: StatusCases? {
		StatusCases(rawValue: status)
	}
	
	/// Lista formateada de demografías asociadas al manga.
	var demographicsFormatted: String {
		guard !genres.isEmpty else { return "No demographics found" }
		return demographics.map({ $0.demographic }).joined(separator: ", ")
	}
	
	/// Periodo de publicación del manga en formato legible.
	var publishedFormatted: String {
		guard let startDate else { return "No publication date" }
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let outputFormatter = DateFormatter()
		// outputFormatter.dateStyle = .medium
		outputFormatter.dateFormat = "yyyy"
		guard let start = formatter.date(from: startDate) else { return "Invalid Date" }
		if let end = endDate, let endParsed = formatter.date(from: end) {
			return "\(outputFormatter.string(from: start)) to \(outputFormatter.string(from: endParsed))"
		} else {
			return outputFormatter.string(from: start)
		}
	}
	
	/// Número de volúmenes formateado como texto.
	var volumesFormatted: String {
		guard let volumes else { return "No volumes" }
		return String(volumes)
	}
	
	/// Sinopsis formateada como texto.
	var synopsisFormatted: String {
		guard let sypnosis else { return "No synopsis text available" }
		return sypnosis
	}
	
	/// Lista formateada de autores del manga.
	var authorsFormatted: String {
		guard !authors.isEmpty else { return "No authors found" }
		return authors.map({ "\($0.role): \($0.fullName)" }).joined(separator: ", ")
	}
	
	/// Lista formateada de géneros del manga.
	var genresFormatted: String {
		guard !genres.isEmpty else { return "No genres found" }
		return genres.map({ $0.genre }).joined(separator: ", ")
	}
	
	/// Lista formateada de temas del manga.
	var themesFormatted: String {
		guard !themes.isEmpty else { return "No themes found" }
		return themes.map({ $0.theme }).joined(separator: ", ")
	}
	
	/// Convierte el manga en una instancia de `MangaInCollection`.
	var toMangaInCollection: MangaInCollection {
		MangaInCollection(id: self.id, manga: self)
	}
	
	/// Valida si el manga tiene toda la información esencial.
	var isValid: Bool {
		!title.isEmpty &&
		imageURL != nil &&
		!synopsisFormatted.isEmpty &&
		!authorsFormatted.isEmpty &&
		!genresFormatted.isEmpty &&
		!themesFormatted.isEmpty &&
		!demographicsFormatted.isEmpty
	}
}
