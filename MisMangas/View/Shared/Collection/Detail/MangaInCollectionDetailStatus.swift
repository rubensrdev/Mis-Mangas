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
						.accessibilityLabel("Volumes owned: \(mangaInCollection.volumesOwned) out of \(volumes)")
						.accessibilityHint("Progress of volumes you own for this manga")
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
				.accessibilityLabel("Volumes owned: \(mangaInCollection.volumesOwned)")
				.accessibilityHint("The total number of volumes is unknown")
			}
			if let volumes = mangaInCollection.manga.volumes {
				HStack {
					Text("Reading volume:")
					Text("\(mangaInCollection.readingVolume)")
						.foregroundStyle(.secondary)
						.accessibilityLabel("Reading volume: \(mangaInCollection.readingVolume) out of \(volumes)")
						.accessibilityHint("Progress of the volume you are currently reading")
				}
				ProgressView(value: Double(mangaInCollection.readingVolume), total: Double(volumes))
					.statusInCollectionStyle()
					.tint(mangaInCollection.completedCollection ? .tertiaryGreen : .primaryBlue)
			} else  {
				HStack {
					Text("Reading volume: ")
					Text("\(mangaInCollection.readingVolume)")
						.foregroundStyle(.secondary)
						.accessibilityLabel("Reading volume: \(mangaInCollection.readingVolume)")
						.accessibilityHint("The total number of volumes is unknown")
				}
			}
			HStack {
				if mangaInCollection.completedCollection {
					Label("Completed", systemImage: "checkmark.shield.fill")
						.collectionCompletedStyle()
						.accessibilityLabel("Collection completed")
						.accessibilityHint("You have completed collecting all volumes for this manga")
				} else {
					Label("Not completed", systemImage: "xmark.shield.fill")
						.collectionNotCompletedStyle()
						.accessibilityLabel("Collection not completed")
						.accessibilityHint("You have not completed collecting all volumes for this manga")
				}
			}
		}
	}
}

#Preview {
	MangaInCollectionDetailStatus(mangaInCollection: .preview)
}
