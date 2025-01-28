//
//  MangaGridCachedImageView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

/// Vista que muestra una imagen de portada de manga para listas en iPad, con soporte para caché.
///
/// - Uso:
///   Diseñada para ser utilizada en listas de mangas en vistas optimizadas para iPad, cargando imágenes de manera
///   eficiente desde la red y almacenándolas en caché.
///
/// - Propiedades:
///   - `url`: URL de la imagen que se debe mostrar.
///   - `cachedImage`: ViewModel que gestiona la carga y el almacenamiento en caché de la imagen.
struct MangaListCachedImageViewIpad: View {
	@State var cachedImage = CachedImageViewModel()
	let url: URL?
	var body: some View {
		VStack {
			if let image = cachedImage.cachedImage {
				Image(uiImage: image)
					.mangaListImgStyleforIpad()
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
	MangaListCachedImageViewIpad(url: Manga.preview.imageURL)
}
