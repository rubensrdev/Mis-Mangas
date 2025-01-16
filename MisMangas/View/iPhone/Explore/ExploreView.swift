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
							Section {
								VStack(alignment: .leading, spacing: 4) {
									Text("Best Mangas")
										.exploreTitleStyle()
									Text("A selection of the 100 best rated")
										.exploreSubtitleStyle()
								}
								.padding(.vertical, 8)
							}
							List {
								ForEach(vm.mangas) { manga in
									NavigationLink(value: manga) {
										HStack {
											VStack(alignment: .leading) {
												Text(manga.title)
													.font(.headline)
													.foregroundStyle(.primaryDark)
												Text(manga.scoreFormatted)
													.scoreStyle()
											}
											Spacer()
											MangaListCachedImageView(url: manga.imageURL)
										}
										
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
							Section {
								VStack(alignment: .leading, spacing: 4) {
									Text("Authors")
										.exploreTitleStyle()
									Text("All authors and editors that exist")
										.exploreSubtitleStyle()
								}
								.padding(.vertical, 8)
							}
							List {
								ForEach(vm.authors) { author in
									VStack(alignment: .leading) {
										Text(author.fullName)
											.font(.headline)
										Text(author.role)
											.font(.subheadline)
											.foregroundStyle(.secondary)
									}
									
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							VStack(alignment: .leading, spacing: 4) {
								Text("Demographics")
									.exploreTitleStyle()
								Text("All demographics that exist")
									.exploreSubtitleStyle()
							}
							List {
								ForEach(vm.demographics, id: \.self) { demography in
									VStack(alignment: .leading) {
										Text(demography)
											.font(.headline)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .genres:
						NavigationStack {
							VStack(alignment: .leading, spacing: 4) {
								Text("Genres")
									.exploreTitleStyle()
								Text("All genres that exist")
									.exploreSubtitleStyle()
							}
							List {
								ForEach(vm.genres, id: \.self) { genre in
									VStack(alignment: .leading) {
										Text(genre)
											.font(.headline)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .themes:
						NavigationStack {
							VStack(alignment: .leading, spacing: 4) {
								Text("Themes")
									.exploreTitleStyle()
								Text("All themes that exist")
									.exploreSubtitleStyle()
							}
							List {
								ForEach(vm.themes, id: \.self) { theme in
									VStack(alignment: .leading) {
										Text(theme)
											.font(.headline)
									}
								}
							}
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
				}
				VStack {
					Text("Select category")
						.font(.headline)
						.foregroundStyle(.primaryDark)
					ScrollView(.horizontal) {
						HStack(spacing: 18) {
							ForEach(ExploreOptions.allCases) { option in
								Button {
									vm.changeSelectedOption(to: option)
								} label: {
									Text(option.rawValue)
										.padding(.vertical, 10)
										.padding(.horizontal, 20)
										.background(vm.selectedExploreOption == option ? .primaryBlue : Color.gray.opacity(0.2))
										.foregroundColor(vm.selectedExploreOption == option ? .primaryWhite : .primaryBlue)
										.cornerRadius(12)
										.shadow(color: vm.selectedExploreOption == option ? .primaryBlue.opacity(0.5) : .clear, radius: 5, x: 0, y: 5)
								}
							}
						}
						.padding(.horizontal)
					}
					.padding(.vertical, 10)
					.background(Color(.systemGray6))
					.cornerRadius(15)
					.padding()
				}
			}
		}
	}
}

#Preview {
	ExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
