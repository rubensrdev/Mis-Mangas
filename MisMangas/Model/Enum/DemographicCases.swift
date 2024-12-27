//
//  Demographic.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

enum DemographicCases: String, CaseIterable, Identifiable, Codable {
	case seinen = "Seinen"
	case shounen = "Shounen"
	case shoujo = "Shoujo"
	case josei = "Josei"
	case kids = "Kids"
	
	var id: Self { self }
}
