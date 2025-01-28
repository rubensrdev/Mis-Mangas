//
//  ExploreRowView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 22/1/25.
//

import SwiftUI

// Vista que representa una fila de navegación para explorar mangas por una categoría específica.
///
/// - Uso:
///   Diseñada para ser utilizada en listas dentro de las vistas de exploración, específicamente para navegar
///   a mangas filtrados por una categoría como género, temática o demografía.
struct ExploreRow: View {
	let type: String
	var body: some View {
		NavigationLink(value: type) {
			VStack(alignment: .leading) {
				Text(type)
					.font(.headline)
					.accessibilityLabel("Category: \(type)")
					.accessibilityHint("Tap to explore mangas in the \(type) category")
			}
			.padding()
		}
	}
}

#Preview {
	ExploreRow(type: "Sci-Fi")
}
