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
			ScrollView {
				LazyVGrid(columns: grid, spacing: 50) {
					ForEach(vm.mangas) { manga in
						NavigationLink(value: manga) {
							VStack {
								MangaGridCachedImageView(url: manga.manga.imageURL)
								Text(manga.manga.title)
									.font(.headline)
									.multilineTextAlignment(.center)
									.lineLimit(2).frame(width: 120)
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
		}
    }
}

#Preview {
	CollectionView()
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
