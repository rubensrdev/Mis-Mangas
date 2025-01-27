//
//  MangaAddToCollectionButton.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

import SwiftUI

struct MangaAddToCollectionButton: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
	
	var body: some View {
		VStack {
			switch myCollectionVM.stateForManga(manga.id) {
			case .loading:
				ProgressView()
			case .inCollection:
				Label("I already have it", systemImage: "checkmark.seal.fill")
					.padding(.horizontal, 8)
					.padding(.vertical, 4)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(.tertiaryGreen)
					)
					.foregroundStyle(.primaryWhite)
					.accessibilityLabel("\(manga.title) is already in your collection")
					.accessibilityHint("This manga has already been added to your collection")
			case .notInCollection:
				Button {
					myCollectionVM.addToCollection(manga)
				} label: {
					Label("Add to Collection", systemImage: "plus.circle.fill")
				}
				.buttonStyle(.borderedProminent)
				.tint(.primaryBlue)
				.accessibilityLabel("Add \(manga.title) to your collection")
				.accessibilityHint("Tap to add \(manga.title) to your collection")
			}
		}
	}
}
