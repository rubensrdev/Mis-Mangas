//
//  FilterByTitleAuthorView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct FilterByTitleAuthorView: View {
	@Bindable var customSearchVM: CustomSearchViewModel
	var body: some View {
		Section {
			TextField("Title", text: $customSearchVM.searchTitle)
				.autocapitalization(.none)
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
			Group {
				if customSearchVM.showErrorSearchContains {
					Text("If the toggle is on, at least one of the title or author fields must be filled.")
						.font(.footnote)
						.foregroundStyle(.red)
						.transition(.opacity)
					
				}
			}
			.animation(.easeIn(duration: 0.5), value: customSearchVM.showErrorSearchContains)
		} header: {
			Text("By title and author")
				.font(.headline)
				.foregroundStyle(.primaryBlue)
		}
	}
}

#Preview {
	FilterByTitleAuthorView(customSearchVM: CustomSearchViewModel())
}
