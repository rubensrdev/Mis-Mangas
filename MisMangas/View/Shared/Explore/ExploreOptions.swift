//
//  ExploreOptions.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 14/1/25.
//


import SwiftUI

/// Enumeración que define las opciones disponibles para explorar mangas.
///
/// - Casos:
///   - `bestMangas`: Explora los mangas mejor valorados.
///   - `authors`: Explora autores de mangas.
///   - `demographics`: Explora mangas por demografía.
///   - `genres`: Explora mangas por género.
///   - `themes`: Explora mangas por temática.
enum ExploreOptions: String, CaseIterable, Identifiable	{
	case bestMangas = "Best Mangas"
	case authors = "Authors"
	case demographics = "Demographics"
	case genres = "Genres"
	case themes = "Themes"
	var id: Self { self }
}
