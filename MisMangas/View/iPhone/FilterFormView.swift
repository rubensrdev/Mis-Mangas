//
//  FilterFormView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//
import SwiftUI

struct FilterFormView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MangasViewModel.self) private var mangasVM
	
	@Bindable var customSearchVM: CustomSearchViewModel
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Title", text: $customSearchVM.searchTitle)
						.autocapitalization(.words)
						.autocorrectionDisabled()
					TextField("Author First Name", text: $customSearchVM.searchAuthorFirstName)
						.textContentType(.givenName)
						.autocapitalization(.words)
						.autocorrectionDisabled()
					TextField("Author Last Name", text: $customSearchVM.searchAuthorLastName)
						.textContentType(.name)
						.autocapitalization(.words)
						.autocorrectionDisabled()
					HStack {
						Toggle("Include search substring", isOn: $customSearchVM.searchContains)
					}
					if customSearchVM.showErrorSearchContains {
						Text("If the toggle is on, at least one of the title or author fields must be filled.")
							.font(.footnote)
							.foregroundStyle(.red)
					}
				} header: {
					Text("By title and author")
				}
				Section {
					NavigationLink("Select genres") {
						FilterSelectionView(selectedItems: $customSearchVM.searchGenres, title: "Genres", filterOptionCase: .genre)
					}
					HStack {
						Text("Selected genres:")
						Text(customSearchVM.searchGenresInSelection)
							.lineLimit(2)
					}
					.font(.footnote)
				} header: {
					Text("By genres")
				}
				Section {
					NavigationLink("Select themes") {
						FilterSelectionView(selectedItems: $customSearchVM.searchThemes, title: "Themes", filterOptionCase: .theme)
					}
					HStack {
						Text("Selected themes:")
						Text(customSearchVM.searchThemesInSelection)
							.lineLimit(2)
					}
					.font(.footnote)
				} header: {
					Text("By themes")
				}
				Section {
					NavigationLink("Select demographics") {
						FilterSelectionView(selectedItems: $customSearchVM.searchDemographics, title: "Demographics", filterOptionCase: .theme)
							.lineLimit(2)
					}
					HStack {
						Text("Selected demographics:")
						Text(customSearchVM.searchDemographicsInSelection)
					}
					.font(.footnote)
				} header: {
					Text("By demographics")
				}
				Section {
					EmptyView() // Si no hay contenido principal en la sección
				} footer: {
					Text("You can use these filters freely to fine-tune your search.")
						.font(.footnote)
						.fontWeight(.semibold)
				}
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
							// TODO: Llamar al endpoint de búsqueda con el VM global mangasVM
							dismiss()
						}
					} label: {
						Text("Search")
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
	FilterFormView(customSearchVM: CustomSearchViewModel())
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}
