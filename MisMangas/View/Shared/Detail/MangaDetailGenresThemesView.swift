//
//  MangaDetailGenresThemesView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MangaDetailGenresThemesView: View {
	let manga: Manga
	var body: some View {
		VStack {
			Text("Genres")
				.font(.headline)
				.bold()
			Text(manga.genresFormatted)
			Spacer()
			Text("Themes")
				.font(.headline)
				.bold()
			Text(manga.themesFormatted)
			Spacer()
			Text("Demographics")
				.font(.headline)
				.bold()
			Text(manga.demographicsFormatted)
		}
		.mangaDetailStyle()
	}
}

#Preview {
	MangaDetailGenresThemesView(manga: .preview)
}
