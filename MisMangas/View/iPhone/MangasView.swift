//
//  MangasView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import SwiftUI

struct MangasView: View {
	
	@Environment(MangasViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let grid: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 300))]
	
	var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
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
								if myCollectionVM.isInCollection(manga.id) {
									Label("I already have it", systemImage: "checkmark.seal.fill")
								} else {
									Button {
										myCollectionVM.addToCollection(manga)
									} label: {
										Label("Add to my collection", systemImage: "plus.circle")
									}
								}
							}
							.onAppear {
								vm.loadMoreMangas(id: manga.id)
							}
						}
					}
					if vm.isLoadingMore {
						VStack {
							ProgressView()
								.padding(.vertical, 20)
							Text("Loading more mangas...")
								.font(.footnote)
								.foregroundStyle(.secondary)
						}
					}
					
				}
				.navigationTitle(vm.isSearching ? "Search results" : "Mangas")
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
						}
					}
					ToolbarItem(placement: .topBarTrailing) {
						Button(action: {
							vm.showFilters.toggle()
						}) {
							Label("Filter mangas", systemImage: "line.horizontal.3.decrease.circle")
							
						}
					}
				}
				.sheet(isPresented: $vm.showFilters) {
					FilterFormView(customSearchVM: CustomSearchViewModel())
				}
				if vm.isSearching && vm.mangas.isEmpty {
					VStack {
						Spacer()
						Label("No mangas found...", systemImage: "magnifyingglass.circle")
							.font(.headline)
							.foregroundColor(.secondary)
						Spacer()
					}
				}
				if vm.mangas.isEmpty {
					VStack {
						Spacer()
						ProgressView()
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
						.padding()
						.background(Color.black.opacity(0.8))
						.foregroundColor(.white)
						.cornerRadius(10)
						.padding(.bottom, 20)
						.transition(.move(edge: .bottom).combined(with: .opacity))
						.animation(.easeInOut(duration: 0.5), value: myCollectionVM.showToast)
				}
			}
		}
		
	}
}


#Preview {
	MangasView()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
