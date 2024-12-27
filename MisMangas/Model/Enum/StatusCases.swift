//
//  StatusCases.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

enum StatusCases: String, CaseIterable, Identifiable, Codable {
	
	case finished = "finished"
	case currently_publishing = "currently_publishing"
	case on_hiatus = "on_hiatus"
	
	var id: Self { self }
	
	var displayValue: String {
		switch self {
			case .finished: return "Finished"
			case .currently_publishing: return "Currently publishing"
			case .on_hiatus: return "On hiatus"
		}
	}
}
