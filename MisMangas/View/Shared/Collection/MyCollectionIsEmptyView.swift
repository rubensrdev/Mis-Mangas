//
//  MyCollectionIsEmptyView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que muestra un mensaje cuando la colección del usuario está vacía.
///
/// - Uso:
///   Diseñada para ser utilizada en la vista de la colección (`CollectionView`), indicando que no hay mangas agregados.
struct MyCollectionIsEmptyView: View {
	var body: some View {
		VStack {
			Spacer()
			Image(systemName: "books.vertical")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundStyle(.secondaryGray)
				.accessibilityHidden(true)
			Text("Your collection is empty")
				.font(.headline)
				.foregroundStyle(.primaryDark)
				.accessibilityHint("Add mangas to start building your collection")
			Spacer()
		}
	}
}

#Preview {
	MyCollectionIsEmptyView()
}
