//
//  ExploreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 13/1/25.
//

import SwiftUI

struct ExploreView: View {
	
	@Environment(ExploreViewModel.self) private var vm
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			VStack {
				switch vm.selectedExploreOption {
					case .bestMangas:
						NavigationStack {
							HeaderSectionView(title: "Best Mangas", subtitle: "A selection of the 100 best rated")
							List {
								ForEach(vm.mangas) { manga in
									BestMangaRow(manga: manga)
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
							List {
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
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							HeaderSectionView(title: "Demographics", subtitle: "All demographics that exist")
							List {
								ForEach(vm.demographics, id: \.self) { demography in
									DemographyRow(demography: demography)
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .genres:
						NavigationStack {
							HeaderSectionView(title: "Genres", subtitle: "All genres that exist")
							List {
								ForEach(vm.genres, id: \.self) { genre in
									GenreRow(genre: genre)
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .themes:
						NavigationStack {
							HeaderSectionView(title: "Themes", subtitle: "All themes that exist")
							List {
								ForEach(vm.themes, id: \.self) { theme in
									ThemeRow(theme: theme)
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
	ExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}

