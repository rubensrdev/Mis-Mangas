//
//  RepositoryLocalProtocol.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

/// Protocolo que define las operaciones necesarias para gestionar el almacenamiento local de mangas en la colección.
///
/// - Métodos:
///   - `loadMangasInCollection()`: Recupera la lista de mangas almacenados en la colección local.
///   - `saveMangasInCollection(_:)`: Guarda o actualiza la lista de mangas en la colección local.
protocol RepositoryLocalProtocol {
	func loadMangasInCollection() throws -> [MangaInCollection]
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws
}
