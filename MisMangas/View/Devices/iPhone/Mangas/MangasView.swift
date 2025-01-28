//
//  MangasView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import SwiftUI

/// Vista que muestra una lista de mangas en formato de cuadrícula, con opciones de búsqueda, filtros y navegación detallada.
///
/// - Uso:
///   Permite explorar y buscar mangas, mostrando los resultados en una cuadrícula adaptable. Incluye opciones de filtrado y
///   un botón para desplazarse rápidamente al inicio de la lista.
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
							if vm.mangas.isEmpty && vm.isSearching {
								NoMangasFoundView()
							}
							if vm.isLoadingMore {
								LoadingMoreView()
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
								.accessibilityHint("Tap to filter mangas by name, author or category")
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
	MangasView()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
