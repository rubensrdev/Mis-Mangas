//
//  StatusCases.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import Foundation

/// Enumeración que representa los diferentes estados en los que puede encontrarse un manga.
/// - Casos:
///   - `finished`: El manga ha terminado su publicación.
///   - `currently_publishing`: El manga se encuentra en publicación actualmente.
///   - `on_hiatus`: El manga está en pausa.
enum StatusCases: String, CaseIterable, Identifiable, Codable {
	
	case finished = "finished"
	case currently_publishing = "currently_publishing"
	case on_hiatus = "on_hiatus"
	
	var id: Self { self }
	
	/// Devuelve un valor de texto legible para mostrar en la interfaz de usuario.
	var displayValue: String {
		switch self {
			case .finished: return "Finished"
			case .currently_publishing: return "Currently publishing"
			case .on_hiatus: return "On hiatus"
		}
	}
}
