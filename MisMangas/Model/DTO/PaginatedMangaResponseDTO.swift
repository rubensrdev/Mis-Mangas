//
//  PaginatedMangaResponseDTO.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

struct PaginatedMangaResponseDTO: Codable {
	let page: Int
	let per: Int
	let total: Int
	let items: [MangaDTO]
}
