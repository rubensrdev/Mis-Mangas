//
//  AuthorRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct AuthorRow: View {
	let author: Author
	var body: some View {
		VStack(alignment: .leading) {
			Text(author.fullName)
				.font(.headline)
			Text(author.role)
				.font(.subheadline)
				.foregroundStyle(.secondary)
		}
		.padding()
	}
}

#Preview {
	AuthorRow(author: .preview)
}
