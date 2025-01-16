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
	
	let grid: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 300))]
	
	var body: some View {
		
		@Bindable var vm = vm
		
		VStack {
			switch vm.selectedExploreOption {
				case .bestMangas:
					NavigationStack {
						Section {
							VStack(alignment: .leading, spacing: 4) {
								Text("Best Mangas")
									.font(.largeTitle)
									.bold()
								Text("A selection of the 100 best rated")
									.font(.subheadline)
									.foregroundStyle(.secondary)
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
											Text(manga.scoreFormatted)
												.font(.subheadline)
												.foregroundStyle(.secondary)
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
									.font(.largeTitle)
									.bold()
								Text("All authors and editors that exist")
									.font(.subheadline)
									.foregroundStyle(.secondary)
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
								.font(.largeTitle)
								.bold()
							Text("All demographics that exist")
								.font(.subheadline)
								.foregroundStyle(.secondary)
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
								.font(.largeTitle)
								.bold()
							Text("All genres that exist")
								.font(.subheadline)
								.foregroundStyle(.secondary)
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
								.font(.largeTitle)
								.bold()
							Text("All themes that exist")
								.font(.subheadline)
								.foregroundStyle(.secondary)
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
				ScrollView(.horizontal) {
					HStack(spacing: 18) {
						ForEach(ExploreOptions.allCases) { option in
							Button {
								vm.changeSelectedOption(to: option)
							} label: {
								Text(option.rawValue)
									.padding(.vertical, 10)
									.padding(.horizontal, 20)
									.background(vm.selectedExploreOption == option ? Color.blue : Color.gray.opacity(0.2))
									.foregroundColor(vm.selectedExploreOption == option ? .white : .primary)
									.cornerRadius(12)
									.shadow(color: vm.selectedExploreOption == option ? .blue.opacity(0.5) : .clear, radius: 5, x: 0, y: 5)
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

#Preview {
	ExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
