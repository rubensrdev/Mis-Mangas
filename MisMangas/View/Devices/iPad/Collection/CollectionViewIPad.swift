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
		
		NavigationStack {
			ZStack {
				Color.primaryWhite
					.ignoresSafeArea()
				
				ScrollView {
					if vm.filteredMangas.isEmpty {
						MyCollectionIsEmptyView()
					} else {
						VStack(alignment: .leading, spacing: 16) {
							HeaderSectionView(
								title: String(localized: LocalizedStringResource("My_Collection")),
								subtitle: String(localized: LocalizedStringResource("My_Collection_Sub"))
							)
							.padding(.horizontal, 40)
							
							LazyVGrid(columns: grid, spacing: 20) {
								ForEach(vm.filteredMangas) { manga in
									NavigationLink(value: manga) {
										VStack {
											MangaGridCachedImageViewIPad(url: manga.manga.imageURL)
											Text(manga.manga.title)
												.mangaTitleStyle()
												.accessibilityLabel("Title: \(manga.manga.title)")
										}
										.mangaRowStyleIPad()
									}
									.contextMenu {
										Button {
											vm.showRemoveAlert(for: manga)
										} label: {
											Label("Remove from collection", systemImage: "trash")
												.symbolRenderingMode(.palette)
										}
										.accessibilityLabel("Remove \(manga.manga.title) from collection")
										.accessibilityHint("Tap to remove \(manga.manga.title) from your collection")
									}
								}
							}
							.padding()
						}
					}
				}
				.navigationDestination(for: MangaInCollection.self, destination: { manga in
					if let index = vm.mangas.firstIndex(where: { $0.id == manga.id }) {
						MangaInCollectionDetailView(mangaInCollection: $vm.mangas[index])
							.accessibilityLabel("Details for \(manga.manga.title)")
							.accessibilityHint("Tap to view and manage details about \(manga.manga.title)")
					}
				})
				.searchable(text: $vm.searchText, prompt: "Search by manga title")
				.accessibilityLabel("Search field")
				.accessibilityHint("Enter a manga title to filter your collection")
				.orderByToolbar(orderOption: $vm.orderOption)
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
	CollectionViewIPad()
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
