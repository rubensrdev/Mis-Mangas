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
				MangaListCachedImageView(url: manga.imageURL)
				VStack(alignment: .leading) {
					Text(manga.title)
						.font(.headline)
						.foregroundStyle(.primaryDark)
					Text(manga.scoreFormatted)
						.scoreStyle()
				}
				.padding(.horizontal)
				
			}
			
		}
	}
}

#Preview {
	BestMangaRow(manga: .preview)
}
