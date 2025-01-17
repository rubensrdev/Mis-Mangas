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
			Text(manga.authorsFormatted)
		}
		.mangaDetailStyle()
	}
}

#Preview {
	MangaDetailAuthorsView(manga: .preview)
}
