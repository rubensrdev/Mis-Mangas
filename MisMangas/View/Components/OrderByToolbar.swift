//
//  OrderByToolbar.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 5/1/25.
//

import SwiftUI

/// Enumeración que define las opciones de ordenación disponibles para la colección.
///
/// - Casos:
///   - `byTitle`: Ordena los mangas por título.
///   - `byCollectionComplete`: Ordena los mangas según si la colección está completa.
enum OrderOptions: String, CaseIterable, Identifiable {
	case byTitle = "By title"
	case byCollecionComplete = "By collection complete"
	var id: Self { self }
}

/// Modificador que agrega un menú de ordenación a la barra de herramientas de la vista.
///
/// - Uso:
///   Diseñada para ser utilizada en vistas de colección, permitiendo al usuario cambiar el criterio de ordenación.
struct OrderByCollectionToolbar: ViewModifier {
	@Binding var orderOption: OrderOptions
	func body(content: Content) -> some View {
		content
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Menu {
						ForEach(OrderOptions.allCases) { option in
							Button {
								orderOption = option
							} label: {
								Label(option.rawValue, systemImage: option == orderOption ? "checkmark" : "circle")
									.symbolRenderingMode(.palette)
									.foregroundStyle(
										option == orderOption ? .primaryBlue : .primaryDark.opacity(0.5)
									)
							}
							.accessibilityLabel("\(option.rawValue)")
							.accessibilityHint(option == orderOption ? "Currently selected" : "Tap to select this order option")
						}
					} label: {
						Label("Order by", systemImage: "arrow.up.arrow.down")
							.foregroundStyle(.primaryBlue)
							.accessibilityLabel("Order by menu")
							.accessibilityHint("Tap to choose how to order your collection")
					}
				}
			}
	}
}

extension View {
	/// Agrega el modificador `orderByToolbar` a cualquier vista.
	func orderByToolbar(orderOption: Binding<OrderOptions>) -> some View {
		modifier(OrderByCollectionToolbar(orderOption: orderOption))
	}
}
