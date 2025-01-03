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
	
	var showErrorSearchContains: Bool {
		searchContains && (searchTitle.isEmpty && searchAuthorFirstName.isEmpty && searchAuthorLastName.isEmpty)
	}
	
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
	
	func validate() -> CustomSearch? {
		var errors = ""
		var errorCount = 0
		if validateNonEmptyFilters() {
			errorCount += 1
			errors.append("\(errorCount) - You must fill in or select at least one filter to be able to perform the search.\n")
		}
		if !validateTitleAndAuthorIfSearchContainsIsTrue() {
			errorCount += 1
			errors.append("\(errorCount) - If the toggle is on, at least one of the title or author fields must be filled.\n")
		}
		if errorCount > 0 {
			errorMessage = errors
			showAlert.toggle()
			return nil
		}
		return customSearchValid
	}
	
	private func validateNonEmptyFilters() -> Bool {
		return (searchTitle.isEmpty && searchAuthorFirstName.isEmpty && searchAuthorLastName.isEmpty && searchGenresInSelection.isEmpty && searchThemesInSelection.isEmpty && searchDemographicsInSelection.isEmpty)
	}
	
	private func validateTitleAndAuthorIfSearchContainsIsTrue() -> Bool {
		guard searchContains else { return true }
		return !searchTitle.isEmpty || !searchAuthorFirstName.isEmpty || !searchAuthorLastName.isEmpty
	}
}

extension CustomSearchViewModel {
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
	
	var customSearchValid: CustomSearch {
		CustomSearch(
			searchTitle: searchTitle.isEmpty ? nil : searchTitle,
			searchAuthorFirstName: searchAuthorFirstName.isEmpty ? nil : searchAuthorFirstName,
			searchAuthorLastName: searchAuthorLastName.isEmpty ? nil : searchAuthorLastName,
			searchGenres: searchGenres.isEmpty ? nil : Array(searchGenres),
			searchThemes: searchThemes.isEmpty ? nil : Array(searchThemes),
			searchDemographics: searchDemographics.isEmpty ? nil : Array(searchDemographics),
			searchContains: searchContains,
			page: "1",
			perPage: "12"
		)
	}
}
