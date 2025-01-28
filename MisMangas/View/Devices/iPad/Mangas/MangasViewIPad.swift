//
//  MangasViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

/// Vista optimizada para iPad que muestra una cuadrícula de mangas con opciones de búsqueda, filtros y navegación detallada.
///
/// - Uso:
///   Permite explorar y buscar mangas, mostrando los resultados en una cuadrícula con más columnas adaptadas a pantallas grandes.
///   Incluye opciones de filtrado y un botón para desplazarse rápidamente al inicio de la lista.
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
								title: String(localized: vm.isSearching ? LocalizedStringResource("Search_Results") : LocalizedStringResource("All_Mangas")),
								subtitle: String(localized: vm.isSearching ? LocalizedStringResource("Search_Found") : LocalizedStringResource("Browse_Mangas"))
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
								LoadingMoreView()
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
								.accessibilityLabel("Reset search")
								.accessibilityHint("Tap to show all mangas again")
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
									.accessibilityLabel("Scroll to top")
									.accessibilityHint("Tap to scroll back to the top of the list")
								}
								Button(action: {
									vm.showFilters.toggle()
								}) {
									Label("Filter mangas", systemImage: "line.horizontal.3.decrease")
										.symbolRenderingMode(.palette)
										.foregroundStyle(.primaryBlue)
								}
								.accessibilityLabel("Open filters form")
								.accessibilityHint("Tap to filter mangas by name, author, or category")
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
				.alert("App Error", isPresented: $vm.showErrorAlert) {
					Button("Close") {
						vm.showErrorAlert.toggle()
					}
				} message: {
					Text(vm.errorMessage)
				}
			}
			.task {
				await vm.loadMangas()
			}
			AddToCollectionToastView(
				showToast: myCollectionVM.showToast,
				mangaNameAdded: myCollectionVM.addedMangaTitle,
				shouldOffset: false
			)
		}
	}
}

#Preview {
	MangasViewIPad()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
