//
//  FilterFormView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//
import SwiftUI

/// Vista que presenta un formulario para filtrar mangas basado en múltiples criterios como título, autor, géneros, temáticas y demografías.
///
/// - Uso:
///   Diseñada para ser presentada como una hoja (`sheet`) desde la vista principal de mangas.
///   Permite seleccionar diferentes filtros y realizar búsquedas avanzadas.
struct FilterFormSheetView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MangasViewModel.self) private var mangasVM
	
	@Bindable var customSearchVM: CustomSearchViewModel
	
	var body: some View {
		NavigationStack {
			Form {
				FilterByTitleAuthorView(customSearchVM: customSearchVM)
					.accessibilityLabel("Filter by title or author")
					.accessibilityHint("Enter a title or author name to filter mangas")
				FilterByGenresView(customSearchVM: customSearchVM)
					.accessibilityLabel("Filter by genres")
					.accessibilityHint("Select one or more genres to filter mangas")
				FilterByThemeView(customSearchVM: customSearchVM)
					.accessibilityLabel("Filter by themes")
					.accessibilityHint("Select one or more themes to filter mangas")
				FilterByDemographicsView(customSearchVM: customSearchVM)
					.accessibilityLabel("Filter by demographics")
					.accessibilityHint("Select one or more demographics to filter mangas")
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
					.accessibilityLabel("Cancel filtering")
					.accessibilityHint("Tap to cancel filtering and return to the previous screen")
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
					.accessibilityLabel("Search mangas")
					.accessibilityHint("Tap to search mangas with the selected filters")
				}
			}
			.alert("Validation Error", isPresented: $customSearchVM.showAlert) {} message: {
				Text(customSearchVM.errorMessage)
					.accessibilityHint("An error occurred while validating the filters, check the fields and try again")
			}
		}
	}
}

#Preview {
	FilterFormSheetView(customSearchVM: CustomSearchViewModel())
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}








