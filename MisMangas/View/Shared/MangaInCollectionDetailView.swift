//
//  MangaInCollectionDetailView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import SwiftUI

struct MangaInCollectionDetailView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MyCollectionViewModel.self) private var vm
	
	@State private var expandedSynopsis = false
	
	@Binding var mangaInCollection: MangaInCollection
	
    var body: some View {
		
		@Bindable var vm = vm
		
		ZStack {
			ScrollView {
				VStack {
					HStack {
						VStack {
							AsyncImage(url: mangaInCollection.manga.imageURL) { image in
								image
									.resizable()
									.scaledToFit()
									.frame(height: 250)
									.clipShape(RoundedRectangle(cornerRadius: 10))
									.shadow(radius: 6)
							} placeholder: {
								ProgressView()
							}
							Text(mangaInCollection.manga.title)
								.font(.title)
								.bold()
								.multilineTextAlignment(.center)
							if let japaneseTitle = mangaInCollection.manga.titleJapanese {
								Text(japaneseTitle)
									.font(.headline)
									.foregroundColor(Color.secondary)
							}
						}
						VStack {
							LabeledContent("Score", value: mangaInCollection.manga.scoreFormatted)
							if let status = mangaInCollection.manga.statusFormatted {
								LabeledContent("Status", value: status.displayValue)
							} else {
								LabeledContent("Status", value: "Unknown")
							}
							LabeledContent("Published", value: mangaInCollection.manga.publishedFormatted)
							LabeledContent("Volumes", value: mangaInCollection.manga.volumesFormatted)
							Divider()
							if let volumes = mangaInCollection.manga.volumes {
								HStack {
									Text("Volumes owned:")
									Text("\(mangaInCollection.volumesOwned)")
										.foregroundStyle(.secondary)
								}
								ProgressView(value: Double(mangaInCollection.volumesOwned), total: Double(volumes))
									.frame(width: 100)
							} else  {
								HStack {
									Text("Volumes owned: ")
									Text("\(mangaInCollection.volumesOwned)")
										.foregroundStyle(.secondary)
								}
							}
							if let volumes = mangaInCollection.manga.volumes {
								HStack {
									Text("Reading volume:")
									Text("\(mangaInCollection.readingVolume)")
										.foregroundStyle(.secondary)
								}
								ProgressView(value: Double(mangaInCollection.readingVolume), total: Double(volumes))
									.frame(width: 100)
							} else  {
								HStack {
									Text("Reading volume: ")
									Text("\(mangaInCollection.readingVolume)")
										.foregroundStyle(.secondary)
								}
							}
							HStack {
								if mangaInCollection.completedCollection {
									Label("Collection completed", systemImage: "checkmark.shield.fill")
										.font(.footnote)
										.padding(10)
										.background(RoundedRectangle(cornerRadius: 10).fill(.green.opacity(0.3)))
								} else {
									Label("Collection not completed", systemImage: "xmark.shield.fill")
										.font(.footnote)
										.padding(10)
										.background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.3)))
								}
							}
						}
					}
					Divider()
					VStack {
						Text("Synopsis")
							.font(.title2)
							.bold()
						if expandedSynopsis {
							Text(mangaInCollection.manga.synopsisFormatted)
						} else {
							Text(mangaInCollection.manga.synopsisFormatted)
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
						Text(mangaInCollection.manga.authorsFormatted)
					}
					Divider()
					VStack {
						Text("Genres")
							.font(.headline)
							.bold()
						Text(mangaInCollection.manga.genresFormatted)
						Spacer()
						Text("Themes")
							.font(.headline)
							.bold()
						Text(mangaInCollection.manga.themesFormatted)
						Spacer()
						Text("Demographics")
							.font(.headline)
							.bold()
						Text(mangaInCollection.manga.demographicsFormatted)
					}
				}
			}
			.navigationTitle("Manga Detail")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						vm.showEditingSheet.toggle()
					} label: {
						Label("Edit collection", systemImage: "pencil")
					}
					
				}
			}
			.sheet(isPresented: $vm.showEditingSheet) {
				EditingMangaInCollectionSheetView(vm: MyCollectionEditViewModel(mangaInCollection: mangaInCollection))
					.presentationDetents([.medium])
			}
		}
    }
}

#Preview {
	NavigationStack {
		MangaInCollectionDetailView(mangaInCollection: .constant(.preview))
			.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
	}
}
