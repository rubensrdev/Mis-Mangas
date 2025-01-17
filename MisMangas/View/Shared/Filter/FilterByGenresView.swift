//
//  FilterByGenresView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct FilterByGenresView: View {
	@Bindable var customSearchVM: CustomSearchViewModel
	var body: some View {
		Section {
			NavigationLink("Select genres") {
				FilterSelectionView(selectedItems: $customSearchVM.searchGenres, title: "Genres", filterOptionCase: .genre)
			}
			HStack {
				Text("Selected genres:")
				Text(customSearchVM.searchGenresInSelection)
					.lineLimit(2)
					.font(.footnote)
					.foregroundStyle(.secondary)
			}
			.font(.footnote)
		} header: {
			Text("By genres")
				.font(.headline)
				.foregroundStyle(.primaryBlue)
		}
	}
}

#Preview {
	FilterByGenresView(customSearchVM: CustomSearchViewModel())
}
