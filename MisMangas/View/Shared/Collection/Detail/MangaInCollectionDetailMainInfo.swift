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
			if let status = mangaInCollection.manga.statusFormatted {
				LabeledContent("Status", value: status.displayValue)
			} else {
				LabeledContent("Status", value: "Unknown")
			}
			LabeledContent("Publication year", value: mangaInCollection.manga.publishedFormatted)
			LabeledContent("Volumes", value: mangaInCollection.manga.volumesFormatted)
		}
	}
}

#Preview {
	MangaInCollectionDetailMainInfo(mangaInCollection: .preview)
}
