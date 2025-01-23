//
//  ExploreMangasByView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 22/1/25.
//

import SwiftUI

import SwiftUI

struct ExploreMangasByView: View {
	
	@Environment(ExploreViewModel.self) private var exploreVM
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	let option: ExploreOptions
	let optionSelected: String

	var body: some View {
		@Bindable var exploreVM = exploreVM
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()

			VStack(alignment: .leading) {
				if exploreVM.mangasForOption.isEmpty {
					ExploreNoMangasFoundView()
				} else {
					List {
						ForEach(exploreVM.mangasForOption) { manga in
							ExploreMangaRow(manga: manga)
								.onAppear {
									Task {
										await exploreVM.loadMoreMangasIfNeeded(for: manga.id, option, optionSelected)
									}
								}
						}
						if exploreVM.isLoadingMangasForOption {
							ProgressView()
								.withStyle()
						}
					}
					.navigationTitle("Mangas for \(optionSelected) in \(option.rawValue.capitalized)")
					.navigationBarTitleDisplayMode(.inline)
					.navigationDestination(for: Manga.self) { manga in
						MangaDetailView(manga: manga)
					}
				}
			}
		}
		.onAppear {
			Task {
				exploreVM.resetStateForOption() 
				await exploreVM.loadMangasForSelectedOption(option, selected: optionSelected)
			}
		}
		.alert("App Error", isPresented: $exploreVM.showErrorAlert) {
			Text(exploreVM.errorMessage)
		}
	}
}

#Preview {
	ExploreMangasByView(option: .demographics, optionSelected: "Seinen")
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}


