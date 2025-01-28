//
//  FilterSelectionView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 31/12/24.
//

import SwiftUI

/// Vista que permite al usuario seleccionar uno o más elementos de una lista como parte de un filtro.
///
/// - Uso:
///   Diseñada para ser utilizada en el contexto de filtros de mangas. Muestra una lista interactiva donde el usuario puede
///   seleccionar o deseleccionar elementos, y se actualizan dinámicamente en un conjunto (`Set`).
struct FilterSelectionView: View {
	
	@Binding var selectedItems: Set<String>
	
	let title: String
	let filterOptionCase: FilterOptionCases
	
    var body: some View {
		List(filterOptionCase.allCases, id: \.self) { item in
			HStack {
				Text(item)
				Spacer()
				if selectedItems.contains(item) {
					Image(systemName: "checkmark")
				}
			}
			.contentShape(Rectangle())
			.onTapGesture {
				if selectedItems.contains(item) {
					selectedItems.remove(item)
				} else {
					selectedItems.insert(item)
				}
			}
		}
		.navigationTitle(title)
		.navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
	NavigationStack {
		FilterSelectionView(selectedItems: .constant([]), title: "Genres", filterOptionCase: .genre)
	}
}
