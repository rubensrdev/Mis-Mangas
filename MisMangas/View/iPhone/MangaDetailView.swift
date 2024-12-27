//
//  MangaDetailView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import SwiftUI

struct MangaDetailView: View {
	
	@Environment(\.dismiss) private var dismiss
	@State private var expandedSynopsis = false
	let manga: Manga
	
	
	var body: some View {
		
		ScrollView {
			VStack {
				HStack {
					VStack {
						AsyncImage(url: manga.imageURL) { image in
							image
								.resizable()
								.scaledToFit()
								.frame(height: 250)
								.clipShape(RoundedRectangle(cornerRadius: 10))
								.shadow(radius: 6)
						} placeholder: {
							ProgressView()
						}
						Text(manga.title)
							.font(.title)
							.bold()
							.multilineTextAlignment(.center)
						if let japaneseTitle = manga.titleJapanese {
							Text(japaneseTitle)
								.font(.headline)
								.foregroundColor(Color.secondary)
						}
					}
					VStack {
						LabeledContent("Score", value: manga.scoreFormatted)
						if let status = manga.statusFormatted {
							LabeledContent("Status", value: status.displayValue)
						} else {
							LabeledContent("Status", value: "Unknown")
						}
						LabeledContent("Demographics", value: manga.demographicsFormatted)
						LabeledContent("Published", value: manga.publishedFormatted)
						LabeledContent("Volumes", value: manga.volumesFormatted)
						
					}
				}
				Divider()
				VStack {
					Text("Synopsis")
						.font(.title2)
						.bold()
					if expandedSynopsis {
						Text(manga.synopsisFormatted)
					} else {
						Text(manga.synopsisFormatted)
							.lineLimit(5)
							.truncationMode(.tail)
					}
					Button {
						expandedSynopsis.toggle()
					} label: {
						Text(expandedSynopsis ? "Show Less" : "Read More")
					}
					.buttonStyle(.bordered)
				}
				Divider()
				VStack {
					Text("Authors")
						.font(.title2)
						.bold()
					Text(manga.authorsFormatted)
				}
				Divider()
				VStack {
					Text("Genres")
						.font(.headline)
						.bold()
					Text(manga.genresFormatted)
					Spacer()
					Text("Themes")
						.font(.headline)
						.bold()
					Text(manga.themesFormatted)
				}
				VStack {
					Button {
						// TODO diferenciar si ya está añadido para mostrar o no el botón
						print("Añadir a mi colección")
					} label: {
						Label("Add to Collection", systemImage: "plus.circle.fill")
					}
					.buttonStyle(.borderedProminent)
				}
			}
		}
		.navigationTitle("Manga Detail")
		.navigationBarTitleDisplayMode(.inline)
		
		
		
	}
}

#Preview {
	NavigationStack {
		MangaDetailView(manga: Manga.mangaPreviewData)
	}
}
