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
			CollectionView()
				.tabItem {
					Label("Collection", systemImage: "rectangle.stack.fill")
				}
		}
    }
}

#Preview {
    EntryViewIPhone()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}
