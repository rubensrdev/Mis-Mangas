//
//  MangaGridCachedImageView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

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
