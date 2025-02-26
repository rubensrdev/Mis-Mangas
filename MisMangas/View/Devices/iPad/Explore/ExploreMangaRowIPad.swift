//
//  BestMangaRowIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 19/1/25.
//
import SwiftUI

/// Fila que representa un manga en las vistas de exploración adaptadas para iPad, mostrando su portada, título y puntuación.
///
/// - Uso:
///   Diseñada para ser utilizada en cuadrículas dentro de las vistas de exploración en iPad. Permite navegar al detalle del manga
///   y agregarlo a la colección del usuario mediante un menú contextual.
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
						.accessibilityLabel("Title: \(manga.title)")
					Text(manga.scoreFormatted)
						.scoreStyle()
						.accessibilityLabel("Score: \(manga.scoreFormatted)")
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
