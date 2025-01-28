//
//  MangaDetailView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import SwiftUI

/// Vista que muestra los detalles de un manga específico, incluyendo su portada, información básica, sinopsis,
/// autores, géneros y temáticas. También permite agregar el manga a la colección del usuario.
///
/// - Uso:
///   Diseñada para ser utilizada dentro de una navegación (`NavigationStack`). Presenta información detallada
///   de un manga en una disposición vertical con secciones divididas.
struct MangaDetailView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MyCollectionViewModel.self) private var myCollectionVM
	
	@State private var expandedSynopsis = false
	
	let manga: Manga
	
	var body: some View {
		
		ZStack {
			Color.primaryWhite
				.ignoresSafeArea()
			ScrollView {
				VStack(spacing: 20) {
					HStack(alignment: .top) {
						MangadetailImageView(manga: manga)
						MangaDetailInfoView(manga: manga)
							.padding(.top, 40)
					}
					.padding(.horizontal)
					Divider()
					MangaDetailSinopsysView(manga: manga, expandedSynopsis: $expandedSynopsis)
					Divider()
					MangaDetailAuthorsView(manga: manga)
					Divider()
					MangaDetailGenresThemesView(manga: manga)
					MangaAddToCollectionButton(manga: manga)
				}
			}
			.navigationTitle("Manga Detail")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

#Preview {
	NavigationStack {
		MangaDetailView(manga: .preview)
			.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
	}
}




