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
				Text(manga.title)
					.mangaTitleStyle()
			}
			.mangaRowStyle()
		}
		.contextMenu {
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
