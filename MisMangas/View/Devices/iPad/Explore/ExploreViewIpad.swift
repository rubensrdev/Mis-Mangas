//
//  ExploreViewIpad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

/// Vista optimizada para iPad que permite explorar mangas organizados por categorías como los mejores mangas,
/// autores, demografías, géneros y temáticas.
///
/// - Uso:
///   Muestra un diseño dinámico que se adapta a la categoría seleccionada. Cada sección incluye un encabezado,
///   cuadrículas o listas personalizadas y opciones de navegación detallada.
struct ExploreViewIpad: View {
	
	@Environment(ExploreViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	var body: some View {
		
		@Bindable var vm = vm
		
		let gridThreeColumns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
		let gridTwoColumns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
		let gridOneColumn: [GridItem] = [GridItem(.flexible())]
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			VStack {
				switch vm.selectedExploreOption {
					case .bestMangas:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Best_Mangas")),
									subtitle: String(localized: LocalizedStringResource("Best_Mangas_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
								ScrollView {
									LazyVGrid(columns: gridThreeColumns, spacing: 30) {
										ForEach(vm.mangas) { manga in
											ExploreMangaRowIPad(manga: manga)
										}
									}
								}
								.padding()
							}
							.navigationDestination(for: Manga.self, destination: { manga in
								MangaDetailView(manga: manga)
									.accessibilityLabel("Details for \(manga.title)")
									.accessibilityHint("Tap to view more information about \(manga.title)")
							})
						}
						.task {
							await vm.loadForSelectedOption()
						}
					case .authors:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Authors_Title")),
									subtitle: String(localized: LocalizedStringResource("Authors_Sub"))
								)
								.padding()
								.padding(.horizontal, 40)
								ScrollView {
									LazyVGrid(columns: gridThreeColumns) {
										ForEach(vm.authors) { author in
											AuthorRow(author: author)
												.onAppear {
													vm.checkAndLoadMoreAuthors(current: author)
												}
											if vm.isLoadingMoreAuthors {
												ProgressView()
											}
										}
									}
								}
							}
						}
						.task {
							await vm.loadForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Demographics_Title")),
									subtitle: String(localized: LocalizedStringResource("Demographics_Sub"))
								)
								.padding()
								.padding(.horizontal, 40)
								ScrollView {
									LazyVGrid(columns: gridOneColumn) {
										ForEach(vm.demographics, id: \.self) { demography in
											ExploreRow(type: demography)
										}
									}
									.navigationDestination(for: String.self) { demography in
										ExploreMangasByView(option: .demographics, optionSelected: demography)
											.accessibilityLabel("Mangas for \(demography)")
											.accessibilityHint("Tap to view mangas for \(demography)")
									}
								}
							}
						}
						.task {
							await vm.loadForSelectedOption()
						}
					case .genres:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Genres_Title")),
									subtitle: String(localized: LocalizedStringResource("Genres_Sub"))
								)
								.padding()
								.padding(.horizontal, 40)
								ScrollView {
									LazyVGrid(columns: gridTwoColumns) {
										ForEach(vm.genres, id: \.self) { genre in
											ExploreRow(type: genre)
										}
									}
									.navigationDestination(for: String.self) { genre in
										ExploreMangasByView(option: .genres, optionSelected: genre)
											.accessibilityLabel("Mangas for \(genre)")
											.accessibilityHint("Tap to view mangas for \(genre)")
									}
								}
							}
						}
						.task {
							await vm.loadForSelectedOption()
						}
					case .themes:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Themes_Title")),
									subtitle: String(localized: LocalizedStringResource("Themes_Sub"))
								)
								.padding()
								.padding(.horizontal, 40)
								ScrollView {
									LazyVGrid(columns: gridTwoColumns) {
										ForEach(vm.themes, id: \.self) { theme in
											ExploreRow(type: theme)
										}
									}
									.navigationDestination(for: String.self) { theme in
										ExploreMangasByView(option: .themes, optionSelected: theme)
										accessibilityLabel("Mangas for \(theme)")
										.accessibilityHint("Tap to view mangas for \(theme)")
									}
								}
							}
						}
						.task {
							await vm.loadForSelectedOption()
						}
				}
				SubmenuExploreView()
			}
			AddToCollectionToastView(
				showToast: myCollectionVM.showToast,
				mangaNameAdded: myCollectionVM.addedMangaTitle,
				shouldOffset: true
			)
		}
	}
}

#Preview {
	ExploreViewIpad()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
