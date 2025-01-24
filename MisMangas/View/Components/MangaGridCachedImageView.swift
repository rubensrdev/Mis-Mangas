//
//  MangaGridCachedImageView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import SwiftUI

struct MangaGridCachedImageView: View {
	@State var cachedImage = CachedImageViewModel()
	let url: URL?
	var body: some View {
		VStack {
			if let image = cachedImage.cachedImage {
				Image(uiImage: image)
					.mangaGridImgStyle()
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
