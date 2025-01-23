//
//  MangaContextMenu.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 21/1/25.
//

import SwiftUI

struct MangaAddToCollectionContextMenu: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
    var body: some View {
		if myCollectionVM.isInCollection(manga.id) {
			Label("I already have it", systemImage: "checkmark.seal.fill")
				.symbolRenderingMode(.palette)
		} else {
			Button {
				myCollectionVM.addToCollection(manga)
			} label: {
				Label("Add to my collection", systemImage: "plus.circle")
					.symbolRenderingMode(.palette)
			}
		}
    }
}

#Preview {
	MangaAddToCollectionContextMenu(manga: .preview)
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
