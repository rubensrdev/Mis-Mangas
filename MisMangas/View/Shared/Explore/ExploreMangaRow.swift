//
//  BestMangaRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct ExploreMangaRow: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
	var body: some View {
		NavigationLink(value: manga) {
			HStack {
				MangaListCachedImageView(url: manga.imageURL)
				VStack(alignment: .leading) {
					Text(manga.title)
						.font(.headline)
						.foregroundStyle(.primaryDark)
					Text(manga.scoreFormatted)
						.scoreStyle()
				}
				.padding(.horizontal)
			}
		}
		.swipeActions( allowsFullSwipe: false) {
			if myCollectionVM.isInCollection(manga.id) {
				Button {} label: {
					Label("I already have it", systemImage: "checkmark.seal.fill")
						.symbolRenderingMode(.palette)
				}
				.tint(.gray)
				.disabled(true)
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
}

#Preview {
	ExploreMangaRow(manga: .preview)
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
