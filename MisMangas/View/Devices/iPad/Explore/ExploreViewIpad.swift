//
//  ExploreViewIpad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

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
							HeaderSectionView(title: "Best Mangas", subtitle: "A selection of the 100 best rated")
							ScrollView {
								LazyVGrid(columns: gridThreeColumns, spacing: 30) {
									ForEach(vm.mangas) { manga in
										BestMangaRowIPad(manga: manga)
									}
								}
							}
							.navigationDestination(for: Manga.self, destination: { manga in
								MangaDetailView(manga: manga)
							})
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .authors:
						NavigationStack {
							HeaderSectionView(title: "Authors", subtitle: "All authors and editors that exist")
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
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							HeaderSectionView(title: "Demographics", subtitle: "All demographics that exist")
							ScrollView {
								LazyVGrid(columns: gridOneColumn) {
									ForEach(vm.demographics, id: \.self) { demography in
										DemographyRow(demography: demography)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .genres:
						NavigationStack {
							HeaderSectionView(title: "Genres", subtitle: "All genres that exist")
							ScrollView {
								LazyVGrid(columns: gridTwoColumns) {
									ForEach(vm.genres, id: \.self) { genre in
										GenreRow(genre: genre)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .themes:
						NavigationStack {
							HeaderSectionView(title: "Themes", subtitle: "All themes that exist")
							ScrollView {
								LazyVGrid(columns: gridTwoColumns) {
									ForEach(vm.themes, id: \.self) { theme in
										ThemeRow(theme: theme)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
				}
				SubmenuExploreView()
			}
		}
	}
}

#Preview {
	ExploreViewIpad()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}


