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
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Best_Mangas")),
									subtitle: String(localized: LocalizedStringResource("Best_Mangas_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
								List {
									ForEach(vm.mangas) { manga in
										BestMangaRow(manga: manga)
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
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Authors_Title")),
									subtitle: String(localized: LocalizedStringResource("Authors_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
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
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Demographics_Title")),
									subtitle: String(localized: LocalizedStringResource("Demographics_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
								List {
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
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Genres_Title")),
									subtitle: String(localized: LocalizedStringResource("Genres_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
								List {
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
							VStack(alignment: .leading, spacing: 0) {
								HeaderSectionView(
									title: String(localized: LocalizedStringResource("Themes_Title")),
									subtitle: String(localized: LocalizedStringResource("Themes_Sub"))
								)
								.padding()
								.padding(.horizontal, 20)
								List {
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
	ExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
