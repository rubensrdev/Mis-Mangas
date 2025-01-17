//
//  ContentView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 24/12/24.
//

import SwiftUI

struct EntryViewIPhone: View {
    var body: some View {
		TabView {
			MangasView()
				.tabItem {
					Label("Mangas", systemImage: "book.fill")
				}
			ExploreView()
				.tabItem {
					Label("Explore", systemImage: "square.grid.2x2.fill")
				}
			CollectionView()
				.tabItem {
					Label("Collection", systemImage: "rectangle.stack.fill")
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
