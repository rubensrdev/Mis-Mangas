//
//  EditingMangaInCollectionSheetView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import SwiftUI

struct EditingMangaInCollectionSheetView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MyCollectionViewModel.self) private var myCollectionVM

	@Bindable var vm: MyCollectionEditViewModel
	
    var body: some View {
		NavigationStack	{
			Form {
				EditingMangaVolumeSection(
					title: "Volumes Owned",
					textFieldPlaceholder: "Enter volumes owned",
					value: $vm.volumesOwned,
					currentInfo: vm.currentlyOwned
				)
				EditingMangaVolumeSection(
					title: "Reading volume",
					textFieldPlaceholder: "Enter reading volume",
					value: $vm.readingVolume,
					currentInfo: vm.currentlyReading
				)
			}
			.navigationTitle("Update status")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button {
						dismiss()
					} label: {
						Text("Cancel")
							.foregroundStyle(.red)
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button {
						if let mangaInCollection = vm.validate() {
							Task {
								myCollectionVM.update(mangaInCollection)
								dismiss()
							}
						}
					} label: {
						Text("Update")
							.foregroundStyle(.primaryBlue)
					}
					
				}
			}
			.alert("Validation Error", isPresented: $vm.showAlert) {} message: {
				Text(vm.errorMessage)
			}
		}
    }
}

#Preview {
	NavigationStack {
		EditingMangaInCollectionSheetView(vm: MyCollectionEditViewModel(mangaInCollection: .preview) )
			.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
	}
}

