//
//  MyCollectionViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

@Observable
final class MyCollectionViewModel {
	
	private let repository: RepositoryLocalProtocol
	
	var showErrorAlert = false
	var errorMessage = ""
	
	var showToast = false
	var addedMangaTitle = ""
	
	var mangas: [MangaInCollection] {
		didSet {
			try? repository.saveMangasInCollection(mangas)
		}
	}
	
	init(repository: RepositoryLocalProtocol = RepositoryLocal()) {
		self.repository = repository
		do {
			mangas = try repository.loadMangasInCollection()
		} catch {
			mangas = []
			errorMessage = "Error loading mangas in collection: \(error)"
			showErrorAlert = true
		}
	}
	
	func isInCollection(_ id: Int) -> Bool {
		mangas.contains(where: { $0.id == id })
	}
	
	@MainActor
	func addToCollection(_ manga: Manga) {
		guard !mangas.contains(where: { $0.id == manga.id }) else { return }
		mangas.append(manga.toMangaInCollection)
		addedMangaTitle = manga.title
		showToast = true
		Task {
			try await Task.sleep(for: .seconds(5))
			showToast = false
		}
	}
	
}
