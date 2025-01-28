//
//  MangaGridCachedImageView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import SwiftUI

/// Vista que muestra una imagen de portada de manga con soporte para caché.
///
/// - Uso:
///   Diseñada para ser utilizada en las listas o cuadrículas de mangas, cargando imágenes de manera eficiente desde la red
///   y almacenándolas en caché.
///
/// - Propiedades:
///   - `url`: URL de la imagen que se debe mostrar.
///   - `cachedImage`: ViewModel que gestiona la carga y el almacenamiento en caché de la imagen.
struct MangaListCachedImageView: View {
	@State var cachedImage = CachedImageViewModel()
	let url: URL?
	var body: some View {
		VStack {
			if let image = cachedImage.cachedImage {
				Image(uiImage: image)
					.mangaListImgStyle()
					.accessibilityLabel("Cover image for this manga")
			} else {
				ProgressView()
					.accessibilityLabel("Loading manga cover image")
			}
		}
		.onAppear {
			if let url = url {
				cachedImage.getImage(url: url)
			}
		}
	}
}

#Preview {
	MangaGridCachedImageView(url: Manga.preview.imageURL)
}
