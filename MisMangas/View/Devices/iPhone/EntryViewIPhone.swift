//
//  ContentView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 24/12/24.
//

import SwiftUI

/// Vista principal para dispositivos iPhone que utiliza una barra de pestañas (`TabView`) para navegar
/// entre las secciones principales de la aplicación: Mangas, Explorar y Colección.
struct EntryViewIPhone: View {
    var body: some View {
		TabView {
			MangasView()
				.tabItem {
					Label("Mangas", systemImage: "book.fill")
						.accessibilityLabel("Mangas section")
						.accessibilityHint("Tap to see and filter a list of all mangas")
				}
			ExploreView()
				.tabItem {
					Label("Explore", systemImage: "square.grid.2x2.fill")
						.accessibilityLabel("Explore section")
						.accessibilityHint("Tap to explore the best mangas, authors and find by category")
				}
			CollectionView()
				.tabItem {
					Label("Collection", systemImage: "rectangle.stack.fill")
						.accessibilityLabel("My Collection section")
						.accessibilityHint("Tap to mange your collection of mangas")
				}
		}
		.tint(.primaryBlue)
    }
}

#Preview {
    EntryViewIPhone()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
