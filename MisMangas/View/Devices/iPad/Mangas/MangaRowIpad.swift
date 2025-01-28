//
//  MangaRowIpad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

/// Vista que representa un manga en formato de fila adaptado para iPad dentro de una cuadrícula.
///
/// - Uso:
///   Diseñada para mostrar la portada y el título de un manga, permitiendo navegar a su detalle y agregarlo a la colección
///   mediante un menú contextual.
struct MangaRowIpad: View {
	
	@Environment(MangasViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let manga: Manga
	
	var body: some View {
		NavigationLink(value: manga) {
			VStack(spacing: 10) {
				MangaGridCachedImageViewIPad(url: manga.imageURL)
					.accessibilityLabel("\(manga.title) cover image")
					.accessibilityHint("Tap to view details about \(manga.title)")
				Text(manga.title)
					.mangaTitleStyle()
					.accessibilityLabel("Title: \(manga.title)")
			}
			.mangaRowStyleIPad()
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
	MangaRowIpad(manga: Manga.preview)
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
