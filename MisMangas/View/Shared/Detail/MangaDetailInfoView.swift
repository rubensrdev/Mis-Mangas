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
				.accessibilityLabel("Score: \(manga.scoreFormatted)")
			if let status = manga.statusFormatted {
				LabeledContent("Status", value: status.displayValue)
					.accessibilityLabel("Status: \(status.displayValue)")
			} else {
				LabeledContent("Status", value: "Unknown")
					.accessibilityLabel("Status: Unknown")
					.accessibilityHint("The status of this manga is not available")
			}
			LabeledContent("Publication year", value: manga.publishedFormatted)
				.accessibilityLabel("Publication year: \(manga.publishedFormatted)")
			LabeledContent("Volumes", value: manga.volumesFormatted)
				.accessibilityLabel("Volumes: \(manga.volumesFormatted)")
		}
		.padding()
		.background(Color.secondaryGray)
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

#Preview {
	MangaDetailInfoView(manga: .preview)
}
