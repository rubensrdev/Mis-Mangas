//
//  CollectionViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

struct CollectionViewIPad: View {
	
	@Environment(MyCollectionViewModel.self) private var vm
	
	let grid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
	
    var body: some View {
		
		@Bindable var vm = vm
		
		NavigationStack	{
			ScrollView {
				LazyVGrid(columns: grid, spacing: 50) {
					ForEach(vm.filteredMangas) { manga in
						NavigationLink(value: manga) {
							VStack {
								MangaGridCachedImageViewIPad(url: manga.manga.imageURL)
								Text(manga.manga.title)
									.mangaTitleStyle()
							}
						}
						.contextMenu {
							Button {
								vm.showRemoveAlert(for: manga)
							} label: {
								Label("Remove from collection", systemImage: "trash")
							}
						}
						.alert("Remove \(vm.removedMangaTitle) from your collection", isPresented: $vm.showRemoveAlert) {
							Button(role: .cancel) {} label: { Text("Cancel") }
							Button(role: .destructive) { vm.removeFromCollection(manga) } label: { Text("Remove") }
						}
					}
				}
			}
			.navigationTitle("My collection")
			.navigationDestination(for: MangaInCollection.self, destination: { manga in
				if let index = vm.mangas.firstIndex(where: { $0.id == manga.id}) {
					MangaInCollectionDetailView(mangaInCollection: $vm.mangas[index])
				}
			})
			.searchable(text: $vm.searchText , prompt: "Search by manga title")
			.orderByToolbar(orderOption: $vm.orderOption)
		}
    }
}

#Preview {
	CollectionViewIPad()
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
