//
//  MangasViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

struct MangasViewIPad: View {
	
	@Environment(MangasViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let grid: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
	
	var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			NavigationStack {
				ScrollView {
					VStack(alignment: .leading, spacing: 16) {
						HeaderSectionView(
							title: vm.isSearching ? "Search results" : "All mangas",
							subtitle: vm.isSearching ? "This is all we have found" : "Browse through a vast collection of mangas"
						)
						.padding(.horizontal, 40)
						
						LazyVGrid(columns: grid, spacing: 20) {
							ForEach(vm.mangas) { manga in
								MangaRowIpad(manga: manga)
							}
						}
						.padding()
						
						if vm.isLoadingMore {
							VStack {
								ProgressView()
									.withStyle()
								Text("Loading more mangas...")
									.font(.footnote)
									.foregroundStyle(.secondaryGray)
							}
						}
					}
				}
				.navigationDestination(for: Manga.self, destination: { manga in
					MangaDetailView(manga: manga)
				})
				.toolbar {
					if vm.isSearching {
						ToolbarItem(placement: .topBarTrailing) {
							Button("Back to all") {
								Task {
									vm.resetSearch()
									await vm.loadMangas()
								}
							}
							.foregroundStyle(.primaryBlue)
						}
					}
					ToolbarItem(placement: .topBarTrailing) {
						Button(action: {
							vm.showFilters.toggle()
						}) {
							Label("Filter mangas", systemImage: "line.horizontal.3.decrease")
								.symbolRenderingMode(.palette)
								.foregroundStyle(.primaryBlue)
						}
					}
				}
				.sheet(isPresented: $vm.showFilters) {
					FilterFormSheetView(customSearchVM: CustomSearchViewModel())
				}
				if vm.isSearching && vm.mangas.isEmpty {
					VStack {
						Spacer()
						Label("No mangas found...", systemImage: "magnifyingglass.circle")
							.notFoundStyle()
						Spacer()
					}
				}
				if vm.mangas.isEmpty {
					VStack {
						Spacer()
						ProgressView()
							.withStyle()
						Spacer()
					}
				}
			}
			.task {
				await vm.loadMangas()
			}
			.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
				Text(vm.errorMessage)
			}
			if myCollectionVM.showToast {
				VStack {
					Spacer()
					Text("\(myCollectionVM.addedMangaTitle) has been added to your collection.")
						.toastStyle()
						.transition(.move(edge: .bottom).combined(with: .opacity))
						.animation(.easeInOut(duration: 0.5), value: myCollectionVM.showToast)
				}
			}
		}
	}
}

#Preview {
	MangasViewIPad()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}

