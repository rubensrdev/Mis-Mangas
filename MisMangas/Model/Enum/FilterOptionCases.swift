//
//  FilterOptionCases.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import Foundation

enum FilterOptionCases {
	
	case genre
	case demographic
	case theme
	
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
