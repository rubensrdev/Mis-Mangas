//
//  ThemeRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct ThemeRow: View {
	let theme: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(theme)
				.font(.headline)
		}
		.padding()
	}
}

#Preview {
	ThemeRow(theme: "Magic")
}
