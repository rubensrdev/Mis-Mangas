//
//  CustomSeachViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

/// ViewModel que gestiona la lógica de una búsqueda personalizada de mangas en la aplicación.
///
/// - Uso:
///   Permite configurar filtros como título, autor, géneros, temáticas y demografías. Valida que al menos un filtro sea
///   seleccionado antes de realizar la búsqueda, y asegura que las condiciones adicionales se cumplan si se activan opciones específicas.
///
@Observable
final class CustomSearchViewModel {
	
	/// Título del manga a buscar.
	var searchTitle: String
	
	/// Nombre del autor a buscar.
	var searchAuthorFirstName: String
	
	/// Apellido del autor a buscar.
	var searchAuthorLastName: String
	
	/// Géneros seleccionados para la búsqueda.
	var searchGenres: Set<String>
	
	/// Temáticas seleccionadas para la búsqueda.
	var searchThemes: Set<String>
	
	/// Demografías seleccionadas para la búsqueda.
	var searchDemographics: Set<String>
	
	/// Indicador de búsqueda avanzada por coincidencias.
	var searchContains: Bool
	
	/// Determina si se debe mostrar un error cuando `searchContains` está activado
	/// pero no hay campos relevantes completados.
	var showErrorSearchContains: Bool {
		searchContains && (searchTitle.isEmpty && searchAuthorFirstName.isEmpty && searchAuthorLastName.isEmpty)
	}
	
	/// Bandera para mostrar una alerta de error
	var showAlert = false
	
	/// Mensaje de error que se muestra en caso de que la validación falle.
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
	
	/// Valida los filtros seleccionados y construye un objeto `CustomSearch` si son válidos.
	///
	/// - Retorno: Un objeto `CustomSearch` si la validación es exitosa, `nil` si falla.
	/// - Comportamiento:
	///   - Genera mensajes de error acumulativos si los filtros no son válidos.
	///   - Activa `showAlert` y asigna `errorMessage` si ocurre un error.
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
	
	/// Valida que al menos un filtro esté seleccionado.
	private func validateNonEmptyFilters() -> Bool {
		return (searchTitle.isEmpty && searchAuthorFirstName.isEmpty && searchAuthorLastName.isEmpty && searchGenresInSelection.isEmpty && searchThemesInSelection.isEmpty && searchDemographicsInSelection.isEmpty)
	}
	
	/// Valida que al menos uno de los campos de título o autor esté completado si `searchContains` está activado.
	private func validateTitleAndAuthorIfSearchContainsIsTrue() -> Bool {
		guard searchContains else { return true }
		return !searchTitle.isEmpty || !searchAuthorFirstName.isEmpty || !searchAuthorLastName.isEmpty
	}
}

extension CustomSearchViewModel {
	
	/// Lista de géneros seleccionados como una cadena separada por comas.
	var searchGenresInSelection: String {
		guard !searchGenres.isEmpty else { return "" }
		return searchGenres.joined(separator: ", ")
	}
	
	/// Lista de temáticas seleccionadas como una cadena separada por comas.
	var searchThemesInSelection: String {
		guard !searchThemes.isEmpty else { return "" }
		return searchThemes.joined(separator: ", ")
	}
	
	/// Lista de demografías seleccionadas como una cadena separada por comas.
	var searchDemographicsInSelection: String {
		guard !searchDemographics.isEmpty else { return "" }
		return searchDemographics.joined(separator: ", ")
	}
	
	/// Construye un objeto `CustomSearch` con los filtros válidos.
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
