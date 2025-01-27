//
//  MangaState.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/1/25.
//

import Foundation

enum MangaState: String, CaseIterable, Identifiable {
	case loading
	case inCollection
	case notInCollection
	var id: Self { self }
}
