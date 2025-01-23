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
	
	@State private var showGoToTopToolbar = false
	
	var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			NavigationStack {
				ScrollViewReader { proxy in
					ScrollView {
						VStack(alignment: .leading) {
							HeaderSectionView(
								title: String(localized: vm.isSearching ? LocalizedStringResource("Search_Results") : LocalizedStringResource("All_Mangas")),
								subtitle: String(localized: vm.isSearching ? LocalizedStringResource("Search_Found") : LocalizedStringResource("Browse_Mangas"))
							)
							.padding(.horizontal, 40)
							.id("top")
							LazyVGrid(columns: grid, spacing: 20) {
								ForEach(vm.mangas) { manga in
									MangaRow(manga: manga)
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
							// Esto lo hago para detectar el desplazamiento por la pantalla
							// y así poder mostrar el toolbar para subir arriba del todo
							// sin tener que hacer slide
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
			AddToCollectionToastView(
				showToast: myCollectionVM.showToast,
				mangaNameAdded: myCollectionVM.addedMangaTitle
			)
		}
	}
}

#Preview {
	MangasView()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
