//
//  CustomSeachViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

@Observable
final class CustomSearchViewModel {
	
	var searchTitle: String
	var searchAuthorFirstName: String
	var searchAuthorLastName: String
	var searchGenres: Set<String>
	var searchThemes: Set<String>
	var searchDemographics: Set<String>
	var searchContains: Bool
	
	var showAlert = false
	var errorMessage = ""
	
	init() {
		searchTitle = ""
		searchAuthorFirstName = ""
		searchAuthorLastName = ""
		searchGenres = []
		searchThemes = []
		searchDemographics = []
		searchContains = false
	}
	
	
}
