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
		print("Load mangas in collection preview")
		let data = try Data(contentsOf: urlDocCollection)
		let collection = try JSONDecoder().decode([MangaInCollection].self, from: data)
		return collection
	}
	
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws {
		print("Saving mangas in collection preview")
	}
}
