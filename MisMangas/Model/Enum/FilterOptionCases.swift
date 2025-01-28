//
//  FilterOptionCases.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

/// Enumeración que representa las diferentes opciones de filtro disponibles en la aplicación.
///
/// - Casos:
///   - `genre`: Filtro basado en géneros.
///   - `demographic`: Filtro basado en demografías.
///   - `theme`: Filtro basado en temáticas.
enum FilterOptionCases {
	
	case genre
	case demographic
	case theme
	
	/// Devuelve una lista de cadenas que representan todas las opciones posibles del filtro seleccionado.
	var allCases: [String] {
		switch self {
			case .genre:
				return GenreCases.allCases.map { $0.rawValue }
			case .demographic:
				return DemographicCases.allCases.map { $0.rawValue }
			case .theme:
				return ThemeCases.allCases.map { $0.rawValue }
		}
	}

}
