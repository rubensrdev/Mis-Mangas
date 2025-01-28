//
//  Endpoints.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Enumeración que define los diferentes endpoints disponibles en la API para interactuar con los datos de mangas.
///
/// - Casos:
///  - `listMangas`: Endpoint para listar mangas con paginación.
///  - `listBestMangas`: Endpoint para listar los mangas mejor valorados.
///  - `listAuthors`: Endpoint para listar todos los autores.
///  - `listDemographics`: Endpoint para listar todas las demografías.
///  - `listGenres`: Endpoint para listar todos los géneros.
///  - `listThemes`: Endpoint para listar todas las temáticas.
///  - `searchMangas`: Endpoint para realizar búsquedas avanzadas de mangas.
///  - `listMangaByDemographic`: Endpoint para listar mangas por demografía.
///  - `listMangaByGenre`: Endpoint para listar mangas por género.
///  - `listMangaByTheme`: Endpoint para listar mangas por temática.
enum Endpoints: String {
	case listMangas = "/list/mangas"
	case listBestMangas = "/list/bestMangas"
	case listAuthors = "/list/authors"
	case listDemographics = "/list/demographics"
	case listGenres = "/list/genres"
	case listThemes = "/list/themes"
	case searchMangas = "/search/manga"
	case listMangaByDemographic = "/list/mangaByDemographic"
	case listMangaByGenre = "/list/mangaByGenre"
	case listMangaByTheme = "/list/mangaByTheme"
}

extension Endpoints {
	/// Devuelve el valor asociado al caso de forma más legible
	var path: String {
		self.rawValue
	}
}
