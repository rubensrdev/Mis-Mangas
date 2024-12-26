//
//  Genre.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

enum Genre: String, CaseIterable, Identifiable, Codable {
	case action = "Action"
	case adventure = "Adventure"
	case awardWinning = "Award Winning"
	case drama = "Drama"
	case fantasy = "Fantasy"
	case horror = "Horror"
	case supernatural = "Supernatural"
	case mystery = "Mystery"
	case sliceOfLife = "Slice of Life"
	case comedy = "Comedy"
	case sciFi = "Sci-Fi"
	case suspense = "Suspense"
	case sports = "Sports"
	case ecchi = "Ecchi"
	case romance = "Romance"
	case girlsLove = "Girls Love"
	case boysLove = "Boys Love"
	case gourmet = "Gourmet"
	case erotica = "Erotica"
	case hentai = "Hentai"
	case avantGarde = "Avant Garde"
	
	var id: Self { self }
}
