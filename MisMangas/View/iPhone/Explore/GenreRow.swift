//
//  GenreRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct GenreRow: View {
	let genre: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(genre)
				.font(.headline)
		}
		.padding()
	}
}

#Preview {
	GenreRow(genre: "Sci-Fi")
}
