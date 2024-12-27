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
		let mainPictureClean = mainPicture
			.replacingOccurrences(of: "\\/", with: "/")
			.trimmingCharacters(in: .init(charactersIn: "\""))
		return URL(string: mainPictureClean)
	}
}
