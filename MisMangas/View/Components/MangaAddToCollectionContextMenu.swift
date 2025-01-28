//
//  MangaContextMenu.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 21/1/25.
//

import SwiftUI


/// Menú contextual que permite agregar un manga a la colección del usuario o indica que ya está en la colección.
///
/// - Uso:
///   Diseñada para ser utilizada como un menú contextual (`contextMenu`) en las vistas que representan mangas.
struct MangaAddToCollectionContextMenu: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
    var body: some View {
		if myCollectionVM.isInCollection(manga.id) {
			Label("I already have it", systemImage: "checkmark.seal.fill")
				.symbolRenderingMode(.palette)
				.accessibilityLabel("\(manga.title) is already in your collection")
				.accessibilityHint("This action is disabled because \(manga.title) is already added")
		} else {
			Button {
				myCollectionVM.addToCollection(manga)
			} label: {
				Label("Add to my collection", systemImage: "plus.circle")
					.symbolRenderingMode(.palette)
			}
			.accessibilityLabel("Add \(manga.title) to your collection")
			.accessibilityHint("Tap to add \(manga.title) to your collection")
		}
    }
}

#Preview {
	MangaAddToCollectionContextMenu(manga: .preview)
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
