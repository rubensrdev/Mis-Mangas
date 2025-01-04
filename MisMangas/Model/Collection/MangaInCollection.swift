//
//  MangaInCollection.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

struct MangaInCollection: Codable, Identifiable, Hashable {
	let id: Int
	let manga: Manga
	var volumesOwned: Int = 0
	var readingVolume: Int = 0
	var completedCollection: Bool {
		guard let volumes = manga.volumes else { return false }
		return readingVolume == volumes
	}
}

