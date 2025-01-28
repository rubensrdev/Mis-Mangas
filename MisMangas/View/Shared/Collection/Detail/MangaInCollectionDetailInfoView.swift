//
//  MangaInCollectionDetailInfoView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI


/// Vista que muestra información detallada sobre un manga dentro de la colección del usuario.
///
/// - Uso:
///   Diseñada para ser utilizada dentro de la vista de detalle del manga en la colección (`MangaInCollectionDetailView`).
///   Divide la información en dos secciones: información principal y estado del manga.
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
