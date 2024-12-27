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
				LazyVGrid(columns: grid) {
					ForEach(vm.mangas) { manga in
						VStack {
							MangaGridCachedImageView(url: manga.imageURL)
							Text(manga.title)
								.font(.headline)
								.multilineTextAlignment(.center)
								.lineLimit(2).frame(width: 120)
							
						}
					}
				}
				.navigationTitle("Mangas")
				// TODO PAGINACIÓN
			}
		}
		.task {
			await vm.loadMangas()
		}
		
    }
}

#Preview {
    MangasView()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}
