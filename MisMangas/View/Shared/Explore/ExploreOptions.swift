//
//  ExploreOptions.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 14/1/25.
//


import SwiftUI

enum ExploreOptions: String, CaseIterable, Identifiable	{
	case bestMangas = "Best Mangas"
	case authors = "Authors"
	case demographics = "Demographics"
	case genres = "Genres"
	case themes = "Themes"
	var id: Self { self }
}
