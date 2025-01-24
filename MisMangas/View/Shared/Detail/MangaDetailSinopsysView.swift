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
				.accessibilityLabel("Synopsis section")
			Group {
				if expandedSynopsis {
					Text(manga.synopsisFormatted)
						.accessibilityLabel("Full synopsis: \(manga.synopsisFormatted)")
						.accessibilityHint("The complete synopsis is displayed")
				} else {
					Text(manga.synopsisFormatted)
						.lineLimit(5)
						.truncationMode(.tail)
						.accessibilityLabel("Synopsis preview: \(manga.synopsisFormatted)")
						.accessibilityHint("Only the first five lines of the synopsis are displayed. Tap Read More to expand")
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
			.accessibilityLabel(expandedSynopsis ? "Show less synopsis" : "Read more synopsis")
			.accessibilityHint(expandedSynopsis ? "Tap to collapse the synopsis" : "Tap to expand the synopsis")
		}
		.padding()
	}
}

#Preview {
	let expandedSynopsis = Binding.constant(true)
	MangaDetailSinopsysView(manga: .preview, expandedSynopsis: expandedSynopsis )
}
