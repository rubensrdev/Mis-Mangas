//
//  RepositoryLocal.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

struct RepositoryLocal: RepositoryLocalProtocol {
	
	private var urlDocCollection: URL {
		.documentsDirectory.appending(path: "/MyMangasCollection.json")
	}
	
	func loadMangasInCollection() throws -> [MangaInCollection] {
		guard FileManager.default.fileExists(atPath: urlDocCollection.path()) else {
			return []
		}
		let data = try Data(contentsOf: urlDocCollection)
		return try JSONDecoder().decode([MangaInCollection].self, from: data)
	}
	
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws {
		let data = try JSONEncoder().encode(mangas)
		try data.write(to: urlDocCollection, options: [.atomic, .completeFileProtection])
	}

}
