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

extension PaginatedMangaResponse {
	func toDTO() -> PaginatedMangaResponseDTO? {
		let mangasDTO = items.compactMap { $0.toDTO() }
		guard !mangasDTO.isEmpty else { return nil }
		
		return PaginatedMangaResponseDTO(
			page: metadata.page,
			per: metadata.per,
			total: metadata.total,
			items: mangasDTO
		)
	}
}
