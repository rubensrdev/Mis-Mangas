//
//  MangaState.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/1/25.
//

import Foundation

/// Enumeración que representa el estado de un manga en relación con la colección del usuario.
///
/// - Casos:
///   - `loading`: Indica que el manga se está cargando.
///   - `inCollection`: Indica que el manga ya está en la colección del usuario.
///   - `notInCollection`: Indica que el manga no está en la colección del usuario.
enum MangaState: String, CaseIterable, Identifiable {
	case loading
	case inCollection
	case notInCollection
	var id: Self { self }
}
