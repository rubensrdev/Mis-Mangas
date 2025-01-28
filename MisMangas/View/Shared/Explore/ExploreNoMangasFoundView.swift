//
//  ExploreNoMangasFoundView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 22/1/25.
//
import SwiftUI


/// Vista que muestra un mensaje cuando no se encuentran mangas en la categoría seleccionada.
///
/// - Uso:
///   Diseñada para ser utilizada dentro de las vistas de exploración (`ExploreMangasByView`) como un estado vacío,
///   indicando que no hay mangas disponibles para los filtros o categorías seleccionadas.
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
