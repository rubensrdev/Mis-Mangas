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
	
	var showErrorSearchContains = false
	var showAlert = false
	var errorMessage = ""
	
	var searchGenresInSelection: String {
		guard !searchGenres.isEmpty else { return "" }
		return searchGenres.joined(separator: ", ")
	}
	
	var searchThemesInSelection: String {
		guard !searchThemes.isEmpty else { return "" }
		return searchThemes.joined(separator: ", ")
	}
	
	var searchDemographicsInSelection: String {
		guard !searchDemographics.isEmpty else { return "" }
		return searchDemographics.joined(separator: ", ")
	}
	
	init() {
		searchTitle = ""
		searchAuthorFirstName = ""
		searchAuthorLastName = ""
		searchGenres = []
		searchThemes = []
		searchDemographics = []
		searchContains = false
	}
	
	func validate() -> CustomSearch? {
		if validateNonEmptyFilters() {
			errorMessage = "You must fill in or select at least one filter to be able to perform the search."
			showAlert.toggle()
			return nil
		}
		if validateTitleAndAuthorIfSearchContainsIsTrue() {
			errorMessage = "If the toggle is on, at least one of the title or author fields must be filled."
			showAlert.toggle()
			return nil
		}
		return CustomSearch(searchTitle: searchTitle, searchAuthorFirstName: searchAuthorFirstName, searchAuthorLastName: searchAuthorLastName, searchGenres: Array(searchGenres), searchThemes: Array(searchThemes), searchDemographics: Array(searchDemographics), searchContains: searchContains)
	}
	
	private func validateNonEmptyFilters() -> (Bool) {
		return (searchTitle.isEmpty && searchAuthorFirstName.isEmpty && searchAuthorLastName.isEmpty && searchGenresInSelection.isEmpty && searchThemesInSelection.isEmpty && searchDemographicsInSelection.isEmpty)
	}
	
	private func validateTitleAndAuthorIfSearchContainsIsTrue() -> Bool {
		guard !searchContains else { return true }
		return !searchTitle.isEmpty || !searchAuthorFirstName.isEmpty || !searchAuthorLastName.isEmpty
	}
}
