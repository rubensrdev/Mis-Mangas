//
//  NoMangasFoundView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//
import SwiftUI

/// Vista que muestra un mensaje cuando no se encuentran mangas, ya sea en la búsqueda o en la colección del usuario.
///
/// - Uso:
///   Diseñada para ser utilizada en vistas donde los resultados de búsqueda o la colección estén vacíos.
struct NoMangasFoundView: View {
	var body: some View {
		VStack {
			Image(systemName: "xmark.circle")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundStyle(.secondaryGray)
				.accessibilityHidden(true)
			Text("No mangas found.")
				.font(.headline)
				.foregroundStyle(.primaryDark)
				.multilineTextAlignment(.center)
				.accessibilityLabel("No mangas found in your collection or search results.")
				.accessibilityHint("Try searching with different criteria or adding mangas to your collection.")
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}
}

#Preview {
	NoMangasFoundView()
}
