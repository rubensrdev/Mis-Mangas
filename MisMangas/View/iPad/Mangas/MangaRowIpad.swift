//
//  MangaRowIpad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct MangaRowIpad: View {
	
	@Environment(MangasViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let manga: Manga
	
	var body: some View {
		NavigationLink(value: manga) {
			VStack(spacing: 10) {
				MangaGridCachedImageViewIPad(url: manga.imageURL)
				Text(manga.title)
					.mangaTitleStyle()
			}
			.padding()
			.background(.secondaryGray)
			.cornerRadius(10)
			.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
		}
		.contextMenu {
			if myCollectionVM.isInCollection(manga.id) {
				Label("I already have it", systemImage: "checkmark.seal.fill")
			} else {
				Button {
					myCollectionVM.addToCollection(manga)
				} label: {
					Label("Add to my collection", systemImage: "plus.circle")
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
	MangaRowIpad(manga: Manga.preview)
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
