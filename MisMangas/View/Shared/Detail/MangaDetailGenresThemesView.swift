//
//  MangaDetailGenresThemesView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI


/// Vista que muestra los géneros, temáticas y demografías de un manga.
///
/// - Uso:
///   Diseñada para ser utilizada como parte de la vista de detalle del manga (`MangaDetailView`).
struct MangaDetailGenresThemesView: View {
	let manga: Manga
	var body: some View {
		VStack {
			Text("Genres")
				.font(.headline)
				.bold()
				.accessibilityLabel("Genres section")
			Text(manga.genresFormatted)
				.accessibilityLabel("Genres: \(manga.genresFormatted)")
			Spacer()
			Text("Themes")
				.font(.headline)
				.bold()
				.accessibilityLabel("Themes section")
			Text(manga.themesFormatted)
				.accessibilityLabel("Themes: \(manga.themesFormatted)")
			Spacer()
			Text("Demographics")
				.font(.headline)
				.bold()
				.accessibilityLabel("Demographics section")
			Text(manga.demographicsFormatted)
				.accessibilityLabel("Demographics: \(manga.demographicsFormatted)")
		}
		.mangaDetailStyle()
	}
}

#Preview {
	MangaDetailGenresThemesView(manga: .preview)
}
