//
//  MangaGridCachedImageViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

struct MangaGridCachedImageViewIPad: View {
	@State var cachedImage = CachedImageViewModel()
	let url: URL?
	var body: some View {
		VStack {
			if let image = cachedImage.cachedImage {
				Image(uiImage: image)
					.mangaGridImgStyleForIPad()
			} else {
				ProgressView()
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
	MangaGridCachedImageViewIPad(url: Manga.preview.imageURL)
}
