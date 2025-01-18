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
			Color.primaryWhite
				.ignoresSafeArea()
			ScrollView {
				VStack(spacing: 20) {
					HStack(alignment: .top) {
						MangadetailImageView(manga: mangaInCollection.manga)
						MangaInCollectionDetailInfoView(mangaInCollection: mangaInCollection)
					}
					.padding(.horizontal)
					Divider()
					MangaDetailSinopsysView(manga: mangaInCollection.manga, expandedSynopsis: $expandedSynopsis)
					Divider()
					MangaDetailAuthorsView(manga: mangaInCollection.manga)
					Divider()
					MangaDetailGenresThemesView(manga: mangaInCollection.manga)
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
							.symbolRenderingMode(.palette)
							.foregroundStyle(.primaryBlue)
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

struct MangaInCollectionDetailMainInfo: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		Group {
			LabeledContent("Score", value: mangaInCollection.manga.scoreFormatted)
			if let status = mangaInCollection.manga.statusFormatted {
				LabeledContent("Status", value: status.displayValue)
			} else {
				LabeledContent("Status", value: "Unknown")
			}
			LabeledContent("Publication year", value: mangaInCollection.manga.publishedFormatted)
			LabeledContent("Volumes", value: mangaInCollection.manga.volumesFormatted)
		}
	}
}

struct MangaInCollectionDetailStatus: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		Group {
			if let volumes = mangaInCollection.manga.volumes {
				HStack {
					Text("Volumes owned:")
					Text("\(mangaInCollection.volumesOwned)")
						.foregroundStyle(.secondary)
				}
				ProgressView(value: Double(mangaInCollection.volumesOwned), total: Double(volumes))
					.statusInCollectionStyle()
					.tint(mangaInCollection.completedCollection ? .tertiaryGreen : .primaryBlue)
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
					.statusInCollectionStyle()
					.tint(mangaInCollection.completedCollection ? .tertiaryGreen : .primaryBlue)
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
						.collectionCompletedStyle()
				} else {
					Label("Collection not completed", systemImage: "xmark.shield.fill")
						.collectionNotCompletedStyle()
				}
			}
		}
	}
}

struct MangaInCollectionDetailInfoView: View {
	let mangaInCollection: MangaInCollection
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			MangaInCollectionDetailMainInfo(mangaInCollection: mangaInCollection)
			Divider()
			MangaInCollectionDetailStatus(mangaInCollection: mangaInCollection)
		}
		.padding()
		.background(Color.secondaryGray)
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}
