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
	
	var showRemoveAlert = false
	var removedMangaTitle = ""
	var mangaToRemove: MangaInCollection?
	
	var showEditingSheet = false
	
	var searchText = ""
	var orderOption = OrderOptions.byTitle
	var filteredMangas: [MangaInCollection] {
		mangas.filter { manga in
			searchText.isEmpty || manga.manga.title.localizedCaseInsensitiveContains(searchText)
		}
		.sorted { manga1, manga2 in
			switch orderOption {
				case .byTitle:
					manga1.manga.title < manga2.manga.title
				case .byCollecionComplete:
					manga1.completedCollection && !manga2.completedCollection
			}
		}
	}
	
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
	
	func showRemoveAlert(for manga: MangaInCollection) {
		mangaToRemove = manga
		removedMangaTitle = manga.manga.title
		showRemoveAlert = true
	}
	
	func removeFromCollection(_ manga: MangaInCollection) {
		mangas.removeAll() { $0.id == manga.id }
		removedMangaTitle = manga.manga.title
	}
	
	func update(_ mangaInCollection: MangaInCollection) {
		if let index = mangas.firstIndex(where: { $0.id == mangaInCollection.id }) {
			mangas[index] = mangaInCollection
		}
	}
	
}
