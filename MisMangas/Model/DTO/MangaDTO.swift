//
//  MangaDTO.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct MangaDTO: Identifiable {
	let id: Int
		let title: String
		let titleJapanese: String
		let titleEnglish: String?
		let background: String
		let mainPicture: URL?
		let sypnosis: String
		let startDate: Date
		let endDate: Date?
		let score: Double
		let status: String
		let chapters: Int?
		let volumes: Int?
		let url: URL?
		let authors: [AuthorDTO]
		let genres: [Genre]
		let themes: [Theme]
		let demographics: [Demographic]
}
