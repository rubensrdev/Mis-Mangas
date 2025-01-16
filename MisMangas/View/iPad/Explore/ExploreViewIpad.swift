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
							Section {
								VStack(alignment: .leading, spacing: 4) {
									Text("Best Mangas")
										.exploreTitleStyle()
									Text("A selection of the 100 best rated")
										.exploreSubtitleStyle()
								}
								.padding(.vertical, 8)
							}
							ScrollView {
								LazyVGrid(columns: gridThreeColumns) {
									ForEach(vm.mangas) { manga in
										NavigationLink(value: manga) {
											VStack(spacing: 10) {
												MangaGridCachedImageViewIPad(url: manga.imageURL)
												Text(manga.title)
													.mangaTitleStyle()
												Text(manga.scoreFormatted)
													.scoreStyle()
											}
											.padding()
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
							ScrollView {
								LazyVGrid(columns: gridThreeColumns) {
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
							ScrollView {
								LazyVGrid(columns: gridOneColumn) {
									ForEach(vm.demographics, id: \.self) { demography in
										VStack(alignment: .leading) {
											Text(demography)
												.font(.headline)
										}
										.padding()
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
							ScrollView {
								LazyVGrid(columns: gridTwoColumns) {
									ForEach(vm.genres, id: \.self) { genre in
										VStack(alignment: .leading) {
											Text(genre)
												.font(.headline)
										}
										.padding()
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
							ScrollView {
								LazyVGrid(columns: gridTwoColumns) {
									ForEach(vm.themes, id: \.self) { theme in
										VStack(alignment: .leading) {
											Text(theme)
												.font(.headline)
										}
										.padding()
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
	ExploreViewIpad()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
