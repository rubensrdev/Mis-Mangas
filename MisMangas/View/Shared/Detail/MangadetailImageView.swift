//
//  MangadetailImageView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que muestra la imagen de portada y los títulos de un manga.
///
/// - Uso:
///   Diseñada para ser utilizada como parte de la vista de detalle del manga (`MangaDetailView`).
///   Presenta la imagen de portada del manga y sus títulos, incluyendo el japonés si está disponible.
struct MangadetailImageView: View {
	let manga: Manga
	var body: some View {
		VStack(spacing: 20) {
			AsyncImage(url: manga.imageURL) { image in
				image
					.resizable()
					.scaledToFit()
					.frame(height: 250)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.shadow(radius: 6)
			} placeholder: {
				ProgressView()
			}
			Text(manga.title)
				.font(.animeAceFontDetail)
				.bold()
				.multilineTextAlignment(.center)
				.foregroundColor(.primaryBlue)
			if let japaneseTitle = manga.titleJapanese {
				Text(japaneseTitle)
					.font(.headline)
					.foregroundColor(.secondary)
			}
		}
	}
}

#Preview {
	MangadetailImageView(manga: .preview)
}
