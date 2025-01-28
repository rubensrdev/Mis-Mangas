//
//  FilterByDemographicsView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct FilterByDemographicsView: View {
	@Bindable var customSearchVM: CustomSearchViewModel
	var body: some View {
		Section {
			NavigationLink("Select demographics") {
				FilterSelectionView(selectedItems: $customSearchVM.searchDemographics, title: "Demographics", filterOptionCase: .demographic)
			}
			HStack {
				Text("Selected demographics:")
				Text(customSearchVM.searchDemographicsInSelection)
					.selectedItemsInCategoryStyle()
			}
			.font(.footnote)
		} header: {
			Text("By demographics")
				.font(.headline)
				.foregroundStyle(.primaryBlue)
				.font(.footnote)
				.foregroundStyle(.secondary)
		}
	}
}

#Preview {
	FilterByDemographicsView(customSearchVM: CustomSearchViewModel())
}
