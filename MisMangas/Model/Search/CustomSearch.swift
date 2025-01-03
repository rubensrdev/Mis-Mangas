//
//  CustomSearch.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

struct CustomSearch: Codable {
	let searchTitle: String?
	let searchAuthorFirstName: String?
	let searchAuthorLastName: String?
	let searchGenres: [String]?
	let searchThemes: [String]?
	let searchDemographics: [String]?
	let searchContains: Bool
	var page: String
	var perPage: String
}
