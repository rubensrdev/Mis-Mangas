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
	
	@State private var showGoToTopToolbar = false
	
	var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			NavigationStack {
				ScrollViewReader { proxy in
					ScrollView {
						VStack(alignment: .leading, spacing: 16) {
							HeaderSectionView(
								title: vm.isSearching ? "Search results" : "All mangas",
								subtitle: vm.isSearching ? "This is all we have found" : "Browse through a vast collection of mangas"
							)
							.padding(.horizontal, 40)
							.id("top")
							
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
						.background(
							// Detectarel desplazamiento para mostrar el botón
							GeometryReader { geo -> Color in
								DispatchQueue.main.async {
									showGoToTopToolbar = geo.frame(in: .global).minY < -100
								}
								return Color.clear
							}
						)
					}
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
							HStack(spacing: 20) {
								if showGoToTopToolbar {
									Button {
										withAnimation {
											proxy.scrollTo("top", anchor: .top)
										}
									} label: {
										Label("Back to Top", systemImage: "arrow.up")
											.symbolRenderingMode(.palette)
											.foregroundStyle(.primaryBlue)
									}
								}
								Button(action: {
									vm.showFilters.toggle()
								}) {
									Label("Filter mangas", systemImage: "line.horizontal.3.decrease")
										.symbolRenderingMode(.palette)
										.foregroundStyle(.primaryBlue)
								}
							}
						}
					}
				}
				.navigationDestination(for: Manga.self, destination: { manga in
					MangaDetailView(manga: manga)
				})
				.sheet(isPresented: $vm.showFilters) {
					FilterFormSheetView(customSearchVM: CustomSearchViewModel())
				}
				.alert("App Error", isPresented: $vm.showErrorAlert) {} message: {
					Text(vm.errorMessage)
				}
			}
			.task {
				await vm.loadMangas()
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
