//
//  EntryViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

struct EntryViewIPad: View {
    var body: some View {
		TabView {
			MangasViewIPad()
				.tabItem {
					Label("Mangas", systemImage: "book.fill")
				}
			ExploreViewIpad()
				.tabItem {
					Label("Explore", systemImage: "square.grid.2x2.fill")
				}
			CollectionViewIPad()
				.tabItem {
					Label("Collection", systemImage: "rectangle.stack.fill")
				}
		}
    }
}

#Preview {
	EntryViewIPad()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
