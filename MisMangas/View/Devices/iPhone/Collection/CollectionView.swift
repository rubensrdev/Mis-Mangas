//
//  CollectionView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import SwiftUI

struct CollectionView: View {
	
	@Environment(MyCollectionViewModel.self) private var vm
	
	let grid: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 300))]
	
	var body: some View {
		
		@Bindable var vm = vm
		
		NavigationStack	{
			ZStack {
				Color.primaryWhite
					.ignoresSafeArea()
				if vm.filteredMangas.isEmpty {
					MyCollectionIsEmptyView()
				} else {
					ScrollView {
						LazyVGrid(columns: grid, spacing: 20) {
							ForEach(vm.filteredMangas) { manga in
								NavigationLink(value: manga) {
									VStack {
										MangaGridCachedImageView(url: manga.manga.imageURL)
										Text(manga.manga.title)
											.mangaTitleStyle()
									}
									.mangaRowStyle()
								}
								.contextMenu {
									Button {
										vm.showRemoveAlert(for: manga)
									} label: {
										Label("Remove from collection", systemImage: "trash")
											.symbolRenderingMode(.palette)
									}
								}
							}
						}
						.padding()
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
			.overlay {
				MangaRemoveAlert(mangaTitle: vm.removedMangaTitle, isPresented: $vm.showRemoveAlert) {
					if let manga = vm.mangaToRemove {
						vm.removeFromCollection(manga)
					}
				}
			}
		}
	}
}

#Preview {
	CollectionView()
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}


