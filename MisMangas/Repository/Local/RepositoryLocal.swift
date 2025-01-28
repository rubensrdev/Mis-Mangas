//
//  RepositoryLocal.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

/// Implementación del repositorio local para gestionar la colección de mangas.
///
/// - Conformidades:
///   - `RepositoryLocalProtocol`: Proporciona las funcionalidades necesarias para cargar y guardar la colección local de mangas.
struct RepositoryLocal: RepositoryLocalProtocol {
	
	/// URL del archivo donde se almacena la colección de mangas en formato JSON.
	private var urlDocCollection: URL {
		.documentsDirectory.appending(path: "/MyMangasCollection.json")
	}
	
	/// Carga la lista de mangas almacenada en la colección local.
	///
	/// - Retorno: Un array de objetos `MangaInCollection` con los mangas guardados.
	/// - Comportamiento:
	///   - Si el archivo no existe, devuelve una colección vacía.
	func loadMangasInCollection() throws -> [MangaInCollection] {
		guard FileManager.default.fileExists(atPath: urlDocCollection.path()) else {
			return []
		}
		let data = try Data(contentsOf: urlDocCollection)
		return try JSONDecoder().decode([MangaInCollection].self, from: data)
	}
	
	/// Guarda o actualiza la lista de mangas en la colección local.
	///
	/// - Parámetro:
	///   - `mangas`: Un array de objetos `MangaInCollection` a guardar.
	/// - Comportamiento:
	///   - El archivo se protege con la opción `.completeFileProtection` para mayor seguridad.
	func saveMangasInCollection(_ mangas: [MangaInCollection]) throws {
		let data = try JSONEncoder().encode(mangas)
		try data.write(to: urlDocCollection, options: [.atomic, .completeFileProtection])
	}

}
