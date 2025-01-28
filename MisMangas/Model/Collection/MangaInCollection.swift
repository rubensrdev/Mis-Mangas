//
//  MangaInCollection.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

/// Representa un manga que pertenece a la colección del usuario.
///
/// - Propiedades:
///  - `id`: Identificador único del manga en la colección.
///  - `manga`: Información detallada del manga asociado a esta entrada de la colección.
///  - `volumesOwned`: Número de volúmenes que el usuario posee de este manga. Por defecto, es `0`.
///  - `readingVolume`: Número del volumen por el que el usuario está leyendo actualmente. Por defecto, es `0`.
///  - `completedCollection`: Propiedad calculada que indica si la colección está completa.
struct MangaInCollection: Codable, Identifiable, Hashable {
	let id: Int
	let manga: Manga
	var volumesOwned: Int = 0
	var readingVolume: Int = 0
	var completedCollection: Bool {
		guard let volumes = manga.volumes else { return false }
		return volumesOwned == volumes
	}
}

