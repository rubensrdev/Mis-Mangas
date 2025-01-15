//
//  ExploreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 13/1/25.
//

import SwiftUI

struct ExploreView: View {
	@Environment(ExploreViewModel.self) private var vm
	let grid: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 300))]
	
	var body: some View {
		
		ZStack {
			VStack {
				Text("Explore")
					.font(.title)
					.bold()
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
				switch vm.selectedExploreOption {
					case .bestMangas:
						NavigationStack {
							List {
								ForEach(vm.mangas) { manga in
									NavigationLink(value: manga) {
										Text(manga.title)
									}
								}
							}
							.navigationTitle("Best Mangas")
							.navigationDestination(for: Manga.self, destination: { manga in
								MangaDetailView(manga: manga)
							})
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .authors:
						NavigationStack {
							List {
								ForEach(vm.authors) { author in
									Text(author.fullName)
								}
							}
							.navigationTitle("Authors")
						}
						.task {
							await vm.loadMangasForSelectedOption()
						}
					case .demographics:
						NavigationStack {
							List {
								ForEach(vm.mangas) { manga in
									NavigationLink(value: manga) {
										Text(manga.title)
									}
								}
							}
						}
					case .genres:
						NavigationStack {
							List {
								ForEach(vm.mangas) { manga in
									NavigationLink(value: manga) {
										Text(manga.title)
									}
								}
							}
						}
					case .themes:
						NavigationStack {
							List {
								ForEach(vm.mangas) { manga in
									NavigationLink(value: manga) {
										Text(manga.title)
									}
								}
							}
						}
				}
				
			}
		}
	}
}

#Preview {
	ExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
