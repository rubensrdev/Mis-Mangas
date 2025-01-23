//
//  LoadingMoreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//
import SwiftUI

struct LoadingMoreView: View {
	var body: some View {
		VStack {
			ProgressView()
				.withStyle()
			Text("Loading more mangas...")
				.font(.footnote)
				.foregroundStyle(.secondaryGray)
				.accessibilityHint("Please wait while we load additional mangas")
		}
	}
}

#Preview {
	LoadingMoreView()
}
