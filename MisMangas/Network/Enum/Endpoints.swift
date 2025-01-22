//
//  Endpoints.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Representa los endpoints disponibles para interactuar con la API.
enum Endpoints: String {
	case listMangas = "/list/mangas"
	case listBestMangas = "/list/bestMangas"
	case listAuthors = "/list/authors"
	case listDemographics = "/list/demographics"
	case listGenres = "/list/genres"
	case listThemes = "/list/themes"
	case searchMangas = "/search/manga"
	case listMangaByDemographic = "/list/mangaByDemographic"
}

extension Endpoints {
	/// retorna el valor asociado al caso de forma más legible
	var path: String {
		self.rawValue
	}
}
