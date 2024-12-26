//
//  PaginatedMangaResponse.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct PaginatedMangaResponse: Codable {
	let metadata: Metadata
	let items: [Manga]
}

