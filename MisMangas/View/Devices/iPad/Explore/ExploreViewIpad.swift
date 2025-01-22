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
											BestMangaRowIPad(manga: manga)
										}
									}
								}
								.padding()
							}
							.navigationDestination(for: Manga.self, destination: { manga in
								MangaDetailView(manga: manga)
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
								}
							}
						}
						.task {
							await vm.loadForSelectedOption()
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
