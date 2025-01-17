//
//  MangaDetailSinopsysView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MangaDetailSinopsysView: View {
	let manga: Manga
	@Binding var expandedSynopsis: Bool
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Synopsis")
				.font(.title2)
				.bold()
			Group {
				if expandedSynopsis {
					Text(manga.synopsisFormatted)
				} else {
					Text(manga.synopsisFormatted)
						.lineLimit(5)
						.truncationMode(.tail)
				}
			}
			.animation(.easeInOut(duration: 0.5), value: expandedSynopsis)
			Button {
				withAnimation(.easeInOut(duration: 0.5)) {
					expandedSynopsis.toggle()
				}
			} label: {
				Text(expandedSynopsis ? "Show Less" : "Read More")
					.font(.subheadline)
					.foregroundStyle(.primaryBlue)
			}
			.buttonStyle(.bordered)
		}
		.padding()
	}
}

#Preview {
	let expandedSynopsis = Binding.constant(true)
	MangaDetailSinopsysView(manga: .preview, expandedSynopsis: expandedSynopsis )
}
