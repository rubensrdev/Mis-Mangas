//
//  ExploreNoMangasFoundView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 22/1/25.
//
import SwiftUI

struct ExploreNoMangasFoundView: View {
	@Environment(ExploreViewModel.self) private var exploreVM
	var body: some View {
		VStack {
			if exploreVM.isLoadingMangasForOption {
				ProgressView()
					.withStyle()
			} else {
				Image(systemName: "xmark.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100)
					.foregroundStyle(.secondaryGray)
				Text("No mangas found.")
					.font(.headline)
					.foregroundStyle(.primaryDark)
			}
		}
	}
}

#Preview {
	ExploreNoMangasFoundView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
