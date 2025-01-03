//
//  Manga.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

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
	
	var scoreFormatted: String {
		score.formatted(.number.precision(.fractionLength(1)))
	}
	
	var statusFormatted: StatusCases? {
		StatusCases(rawValue: status)
	}
	
	var demographicsFormatted: String {
		guard !genres.isEmpty else { return "No demographics found" }
		return demographics.map({ $0.demographic }).joined(separator: ", ")
	}
	
	var publishedFormatted: String {
		guard let startDate else { return "No publication date" }
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let outputFormatter = DateFormatter()
		outputFormatter.dateStyle = .medium
		guard let start = formatter.date(from: startDate) else { return "Invalid Date" }
		if let end = endDate, let endParsed = formatter.date(from: end) {
			return "\(outputFormatter.string(from: start)) - \(outputFormatter.string(from: endParsed))"
		} else {
			return outputFormatter.string(from: start)
		}
	}
	
	var volumesFormatted: String {
		guard let volumes else { return "No volumes" }
		return String(volumes)
	}
	
	var synopsisFormatted: String {
		guard let sypnosis else { return "No synopsis text available" }
		return sypnosis
	}
	
	var authorsFormatted: String {
		guard !authors.isEmpty else { return "No authors found" }
		return authors.map({ "\($0.role): \($0.fullName)" }).joined(separator: ", ")
	}
	
	var genresFormatted: String {
		guard !genres.isEmpty else { return "No genres found" }
		return genres.map({ $0.genre }).joined(separator: ", ")
	}
	
	var themesFormatted: String {
		guard !themes.isEmpty else { return "No themes found" }
		return themes.map({ $0.theme }).joined(separator: ", ")
	}
	
	
	var toMangaInCollection: MangaInCollection {
		MangaInCollection(id: self.id, manga: self)
	}
}
