//
//  MangaInCollectionDetailInfoView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI

struct MangaInCollectionDetailInfoView: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			MangaInCollectionDetailMainInfo(mangaInCollection: mangaInCollection)
			Divider()
			MangaInCollectionDetailStatus(mangaInCollection: mangaInCollection)
		}
		.padding()
		.background(Color.secondaryGray)
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

#Preview {
	MangaInCollectionDetailInfoView(mangaInCollection: .preview)
}
