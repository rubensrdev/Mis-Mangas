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
	var volumesOwned: Int?
	var readingVolume: Int?
	var completedCollection = false
}

