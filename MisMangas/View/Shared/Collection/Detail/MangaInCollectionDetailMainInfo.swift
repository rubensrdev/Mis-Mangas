//
//  MangaInCollectionDetailMainInfo.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI

struct MangaInCollectionDetailMainInfo: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		Group {
			LabeledContent("Score", value: mangaInCollection.manga.scoreFormatted)
				.accessibilityLabel("Score: \(mangaInCollection.manga.scoreFormatted)")
			if let status = mangaInCollection.manga.statusFormatted {
				LabeledContent("Status", value: status.displayValue)
					.accessibilityLabel("Status: \(status.displayValue)")
			} else {
				LabeledContent("Status", value: "Unknown")
					.accessibilityLabel("Status: Unknown")
					.accessibilityHint("The status of this manga is not available")
			}
			LabeledContent("Publication year", value: mangaInCollection.manga.publishedFormatted)
				.accessibilityLabel("Publication year: \(mangaInCollection.manga.publishedFormatted)")
			LabeledContent("Volumes", value: mangaInCollection.manga.volumesFormatted)
				.accessibilityLabel("Volumes: \(mangaInCollection.manga.volumesFormatted)")
		}
	}
}

#Preview {
	MangaInCollectionDetailMainInfo(mangaInCollection: .preview)
}
