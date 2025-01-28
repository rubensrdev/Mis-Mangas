//
//  FilterByThemeView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que permite al usuario seleccionar temáticas como filtro para buscar mangas.
///
/// - Uso:
///   Diseñada para ser utilizada como una sección dentro de un formulario de filtros. Permite navegar a una vista de selección
///   para elegir una o más temáticas y muestra las temáticas seleccionadas en un texto resumido.
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
					.selectedItemsInCategoryStyle()
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
