//
//  MangaDetailInfoView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MangaDetailInfoView: View {
	let manga: Manga
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			LabeledContent("Score", value: manga.scoreFormatted)
			if let status = manga.statusFormatted {
				LabeledContent("Status", value: status.displayValue)
			} else {
				LabeledContent("Status", value: "Unknown")
			}
			LabeledContent("Publication year", value: manga.publishedFormatted)
			LabeledContent("Volumes", value: manga.volumesFormatted)
		}
		.padding()
		.background(Color.secondaryGray)
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

#Preview {
	MangaDetailInfoView(manga: .preview)
}
