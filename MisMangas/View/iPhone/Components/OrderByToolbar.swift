//
//  OrderByToolbar.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 5/1/25.
//

import SwiftUI

enum OrderOptions: String, CaseIterable, Identifiable {
	case byTitle = "By title"
	case byCollecionComplete = "By collection complete"
	var id: Self { self }
}

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
								Text(option.rawValue)
							}
						}
					} label: {
						Text("Order by")
					}
				}
			}
	}
}

extension View {
	func orderByToolbar(orderOption: Binding<OrderOptions>) -> some View {
		modifier(OrderByCollectionToolbar(orderOption: orderOption))
	}
}
