//
//  FilterByGenresView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que permite al usuario seleccionar géneros como filtro para buscar mangas.
///
/// - Uso:
///   Diseñada para ser utilizada como una sección dentro de un formulario de filtros. Permite navegar a una vista de selección
///   para elegir uno o más géneros y muestra los géneros seleccionados en un texto resumido.
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
					.selectedItemsInCategoryStyle()
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
