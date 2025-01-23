//
//  BestMangaRowIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 19/1/25.
//
import SwiftUI

struct ExploreMangaRowIPad: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
	var body: some View {
		NavigationLink(value: manga) {
			VStack(spacing: 10) {
				MangaGridCachedImageViewIPad(url: manga.imageURL)
				HStack {
					Text(manga.title)
						.mangaTitleStyle()
					Text(manga.scoreFormatted)
						.scoreStyle()
				}
			}
			.padding()
			.background(.secondaryGray)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
		}
		.contextMenu {
			MangaAddToCollectionContextMenu(manga: manga)
		}
	}
}

#Preview {
	ExploreMangaRowIPad(manga: .preview)
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
