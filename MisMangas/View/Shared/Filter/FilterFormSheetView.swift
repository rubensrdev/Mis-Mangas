//
//  FilterFormView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//
import SwiftUI

struct FilterFormSheetView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MangasViewModel.self) private var mangasVM
	
	@Bindable var customSearchVM: CustomSearchViewModel
	
	var body: some View {
		NavigationStack {
			Form {
				FilterByTitleAuthorView(customSearchVM: customSearchVM)
				FilterByGenresView(customSearchVM: customSearchVM)
				FilterByThemeView(customSearchVM: customSearchVM)
				FilterByDemographicsView(customSearchVM: customSearchVM)
				FilterFooterView()
			}
			.navigationTitle("Filter Mangas")
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
						if let customSearch = customSearchVM.validate() {
							Task {
								await mangasVM.search(with: customSearch)
								dismiss()
							}
							
						}
					} label: {
						Text("Search")
							.foregroundStyle(.primaryBlue)
					}
					
				}
			}
			.alert("Validation Error", isPresented: $customSearchVM.showAlert) {} message: {
				Text(customSearchVM.errorMessage)
			}
		}
	}
}

#Preview {
	FilterFormSheetView(customSearchVM: CustomSearchViewModel())
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}








