//
//  MangaInCollectionDetailStatus.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI

struct MangaInCollectionDetailStatus: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		Group {
			if let volumes = mangaInCollection.manga.volumes {
				HStack {
					Text("Volumes owned:")
					Text("\(mangaInCollection.volumesOwned)")
						.foregroundStyle(.secondary)
				}
				ProgressView(value: Double(mangaInCollection.volumesOwned), total: Double(volumes))
					.statusInCollectionStyle()
					.tint(mangaInCollection.completedCollection ? .tertiaryGreen : .primaryBlue)
			} else  {
				HStack {
					Text("Volumes owned: ")
					Text("\(mangaInCollection.volumesOwned)")
						.foregroundStyle(.secondary)
				}
			}
			if let volumes = mangaInCollection.manga.volumes {
				HStack {
					Text("Reading volume:")
					Text("\(mangaInCollection.readingVolume)")
						.foregroundStyle(.secondary)
				}
				ProgressView(value: Double(mangaInCollection.readingVolume), total: Double(volumes))
					.statusInCollectionStyle()
					.tint(mangaInCollection.completedCollection ? .tertiaryGreen : .primaryBlue)
			} else  {
				HStack {
					Text("Reading volume: ")
					Text("\(mangaInCollection.readingVolume)")
						.foregroundStyle(.secondary)
				}
			}
			HStack {
				if mangaInCollection.completedCollection {
					Label("Completed", systemImage: "checkmark.shield.fill")
						.collectionCompletedStyle()
				} else {
					Label("Not completed", systemImage: "xmark.shield.fill")
						.collectionNotCompletedStyle()
				}
			}
		}
	}
}

#Preview {
	MangaInCollectionDetailStatus(mangaInCollection: .preview)
}
