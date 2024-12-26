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
	let background: String
	let mainPicture: String?
	let synopsis: String
	let startDate: String
	let endDate: String?
	let score: Double
	let status: String
	let chapters: Int?
	let volumes: Int?
	let url: String?
	let authors: [Author]
	let genres: [String]
	let themes: [String]
	let demographics: [String]
}

extension Manga {
	func toDTO() -> MangaDTO? {
		guard let mainPictureURL = URL(string: mainPicture ?? ""),
			  let url = URL(string: url ?? ""),
			  let startDate = ISO8601DateFormatter().date(from: startDate)
		else { return nil }
		
		let genres = genres.compactMap { Genre(rawValue: $0) }
		let themes = themes.compactMap { Theme(rawValue: $0) }
		let demographics = demographics.compactMap { Demographic(rawValue: $0) }
		
		return MangaDTO(
				id: id,
				title: title,
				titleJapanese: titleJapanese,
				titleEnglish: titleEnglish,
				background: background,
				mainPicture: mainPictureURL,
				sypnosis: synopsis,
				startDate: startDate,
				endDate: endDate.flatMap { ISO8601DateFormatter().date(from: $0) },
				score: score,
				status: status,
				chapters: chapters,
				volumes: volumes,
				url: url,
				authors: authors.map { $0.toDTO() },
				genres: genres,
				themes: themes,
				demographics: demographics
			)
	}
}
