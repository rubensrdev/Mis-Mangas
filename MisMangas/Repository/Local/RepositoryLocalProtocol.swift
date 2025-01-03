//
//  RepositoryLocalProtocol.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

protocol RepositoryLocalProtocol: Sendable {
	func loadMangasInCollection() throws -> [MangaInCollection]
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws
}
