//
//  BestMangaRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct BestMangaRow: View {
	let manga: Manga
	var body: some View {
		NavigationLink(value: manga) {
			HStack {
				VStack(alignment: .leading) {
					Text(manga.title)
						.font(.headline)
						.foregroundStyle(.primaryDark)
					Text(manga.scoreFormatted)
						.scoreStyle()
				}
				Spacer()
				MangaListCachedImageView(url: manga.imageURL)
			}
			
		}
	}
}

#Preview {
	BestMangaRow(manga: .preview)
}
