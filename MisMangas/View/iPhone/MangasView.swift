//
//  MangasView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import SwiftUI

struct MangasView: View {
	
	@Environment(MangasViewModel.self) private var vm
	
	let grid: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 300))]
	
    var body: some View {
		
		@Bindable var vm = vm
		
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: grid, spacing: 50) {
					ForEach(vm.mangas) { manga in
						NavigationLink(value: manga) {
							VStack {
								MangaGridCachedImageView(url: manga.imageURL)
								Text(manga.title)
									.font(.headline)
									.multilineTextAlignment(.center)
									.lineLimit(2).frame(width: 120)
							}
						}
						.contextMenu {
							// TODO ver en VM los que están en la colección para mostrar un botón u otro
							Button {
								print("Agregar a colección si es que no lo tengo ya...")
							} label: {
								Label("Add to my collection", systemImage: "plus.circle")
							}
							Label("I already have it", systemImage: "checkmark.seal.fill")
						}
						.onAppear {
							vm.loadMoreMangas(id: manga.id)
						}
					}
				}
			}
			.navigationTitle("Mangas")
			.navigationDestination(for: Manga.self, destination: { manga in
				MangaDetailView(manga: manga)
			})
			.sheet(isPresented: $vm.showFilters) {
				// TODO SHEET con los filtros de búsqueda
			}
		}
		.task {
			await vm.loadMangas()
		}
		.refreshable {
			await vm.loadMangas()
		}
		.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
			Text(vm.errorMessage)
		}
		
    }
}

#Preview {
    MangasView()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}
