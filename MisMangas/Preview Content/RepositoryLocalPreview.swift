//
//  RepositoryLocalPreview.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

struct RepositoryLocalPreview: RepositoryLocalProtocol {
	
	private var urlDocCollection: URL {
		Bundle.main.url(forResource: "collectionPreview", withExtension: "json")!
	}
	
	
	func loadMangasInCollection() throws -> [MangaInCollection] {
		do {
			print("Loading mangas in collection preview")
			let data = try Data(contentsOf: urlDocCollection)
			return try JSONDecoder().decode([MangaInCollection].self, from: data)
		} catch {
			print("Error loading mangas in collection preview")
			throw error
		}
	}
	
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws {
		print("Saving mangas in collection preview")
	}
	
}

