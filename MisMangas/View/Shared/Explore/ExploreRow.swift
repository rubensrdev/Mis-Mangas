//
//  ExploreRowView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 22/1/25.
//

import SwiftUI

struct ExploreRow: View {
	let type: String
	var body: some View {
		NavigationLink(value: type) {
			VStack(alignment: .leading) {
				Text(type)
					.font(.headline)
					.accessibilityLabel("Category: \(type)")
					.accessibilityHint("Tap to explore mangas in the \(type) category")
			}
			.padding()
		}
	}
}

#Preview {
	ExploreRow(type: "Sci-Fi")
}
