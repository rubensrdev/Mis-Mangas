//
//  Demographic.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

enum Demographic: String, CaseIterable, Identifiable {
	case seinen = "Seinen"
	case shounen = "Shounen"
	case shoujo = "Shoujo"
	case josei = "Josei"
	case kids = "Kids"
	
	var id: Self { self }
}
