//
//  MangaRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct MangaRow: View {
	
	@Environment(MangasViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let manga: Manga
	
	var body: some View {
		NavigationLink(value: manga) {
			VStack {
				MangaGridCachedImageView(url: manga.imageURL)
					.accessibilityLabel("\(manga.title) cover image")
				Text(manga.title)
					.mangaTitleStyle()
					.accessibilityLabel("Title: \(manga.title)")
			}
			.mangaRowStyle()
		}
		.contextMenu {
			MangaAddToCollectionContextMenu(manga: manga)
				.accessibilityLabel("Context menu for \(manga.title)")
				.accessibilityHint("Tap to open the context menu and add \(manga.title) to your collection")
		}
		.onAppear {
			withAnimation(.easeIn(duration: 0.3)) {
				vm.loadMoreMangas(id: manga.id)
			}
			
		}
	}
}

#Preview {
	MangaRow(manga: Manga.preview)
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
