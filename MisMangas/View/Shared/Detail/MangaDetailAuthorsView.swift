//
//  MangaDetailAuthorsView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MangaDetailAuthorsView: View {
	let manga: Manga
	var body: some View {
		VStack(spacing: 10) {
			Text("Authors")
				.font(.title2)
				.bold()
				.accessibilityLabel("Authors section")
				.accessibilityHint("Displays the authors of \(manga.title) and their roles")
			Text(manga.authorsFormatted)
				.accessibilityLabel("Authors: \(manga.authorsFormatted)")
		}
		.mangaDetailStyle()
	}
}

#Preview {
	MangaDetailAuthorsView(manga: .preview)
}
