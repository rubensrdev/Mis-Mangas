//
//  NoMangasFoundView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//
import SwiftUI

struct NoMangasFoundView: View {
	var body: some View {
		VStack {
			Image(systemName: "xmark.circle")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundStyle(.secondaryGray)
			Text("No mangas found.")
				.font(.headline)
				.foregroundStyle(.primaryDark)
				.multilineTextAlignment(.center)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding()
	}
}

#Preview {
	NoMangasFoundView()
}
