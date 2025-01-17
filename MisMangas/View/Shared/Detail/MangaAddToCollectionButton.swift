//
//  MangaAddToCollectionButton.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MangaAddToCollectionButton: View {
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	let manga: Manga
	var body: some View {
		VStack {
			if myCollectionVM.isInCollection(manga.id) {
				Label("I already have it", systemImage: "checkmark.seal.fill")
					.padding(.horizontal, 8)
					.padding(.vertical, 4)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(.tertiaryGreen)
					)
					.foregroundStyle(.primaryWhite)
			} else {
				Button {
					myCollectionVM.addToCollection(manga)
				} label: {
					Label("Add to Collection", systemImage: "plus.circle.fill")
				}
				.buttonStyle(.borderedProminent)
				.tint(.primaryBlue)
			}
		}
	}
}
