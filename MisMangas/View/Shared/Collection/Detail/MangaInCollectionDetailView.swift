//
//  MangaInCollectionDetailView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import SwiftUI

struct MangaInCollectionDetailView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MyCollectionViewModel.self) private var vm
	
	@State private var expandedSynopsis = false
	
	@Binding var mangaInCollection: MangaInCollection
	
    var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			ScrollView {
				VStack(spacing: 20) {
					HStack(alignment: .top) {
						MangadetailImageView(manga: mangaInCollection.manga)
						MangaInCollectionDetailInfoView(mangaInCollection: mangaInCollection)
					}
					.padding(.horizontal)
					Divider()
					MangaDetailSinopsysView(manga: mangaInCollection.manga, expandedSynopsis: $expandedSynopsis)
					Divider()
					MangaDetailAuthorsView(manga: mangaInCollection.manga)
					Divider()
					MangaDetailGenresThemesView(manga: mangaInCollection.manga)
						.padding(.bottom)
				}
			}
			.navigationTitle("Manga Detail")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						vm.showEditingSheet.toggle()
					} label: {
						Label("Edit collection", systemImage: "pencil")
							.symbolRenderingMode(.palette)
							.foregroundStyle(.primaryBlue)
					}
					
				}
			}
			.sheet(isPresented: $vm.showEditingSheet) {
				EditingMangaInCollectionSheetView(vm: MyCollectionEditViewModel(mangaInCollection: mangaInCollection))
					.presentationDetents([.medium])
			}
		}
    }
}

#Preview {
	NavigationStack {
		MangaInCollectionDetailView(mangaInCollection: .constant(.preview))
			.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
	}
}
