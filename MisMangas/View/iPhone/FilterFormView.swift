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
	
	@State private var editMode: EditMode = .active
	
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
					
					Picker(selection: $customSearchVM.searchGenres) {
						ForEach(GenreCases.allCases) { genre in
							Text(genre.rawValue)
								.tag(genre)
						}
					} label: {
						Text("Select genres")
					}
					.pickerStyle(.navigationLink)
					
					Picker(selection: $customSearchVM.searchThemes) {
						ForEach(ThemeCases.allCases) { theme in
							Text(theme.rawValue)
								.tag(theme)
						}
					} label: {
						Text("Select themes")
					}
					.pickerStyle(.navigationLink)
					
					Picker(selection: $customSearchVM.searchDemographics) {
						ForEach(DemographicCases.allCases) { demographic in
							Text(demographic.rawValue)
								.tag(demographic)
						}
					} label: {
						Text("Select demographics")
					}
					.pickerStyle(.navigationLink)
					
				} header: {
					Text("Available filters")
				} footer: {
					Text("You can use these filters freely to fine-tune your search.")
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
						print("Validate fields and search mangas")
					} label: {
						Text("Search")
					}
					
				}
			}
		}
	}
}

#Preview {
	FilterFormView(customSearchVM: CustomSearchViewModel())
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
}
