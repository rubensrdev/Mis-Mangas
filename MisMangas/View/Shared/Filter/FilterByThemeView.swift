//
//  FilterByThemeView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct FilterByThemeView: View {
	@Bindable var customSearchVM: CustomSearchViewModel
	var body: some View {
		Section {
			NavigationLink("Select themes") {
				FilterSelectionView(selectedItems: $customSearchVM.searchThemes, title: "Themes", filterOptionCase: .theme)
			}
			HStack {
				Text("Selected themes:")
				Text(customSearchVM.searchThemesInSelection)
					.lineLimit(2)
					.font(.footnote)
					.foregroundStyle(.secondary)
			}
			.font(.footnote)
		} header: {
			Text("By themes")
				.font(.headline)
				.foregroundStyle(.primaryBlue)
		}
	}
}

#Preview {
	FilterByThemeView(customSearchVM: CustomSearchViewModel())
}
