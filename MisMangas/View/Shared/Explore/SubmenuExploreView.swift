//
//  SubmenuExploreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que muestra un submenú horizontal con las opciones de exploración disponibles.
///
/// - Uso:
///   Diseñada para ser utilizada en la vista de exploración (`ExploreView`). Permite al usuario cambiar entre las distintas
///   categorías de exploración, como mangas destacados, autores, géneros, temáticas y demografías.
struct SubmenuExploreView: View {
	@Environment(ExploreViewModel.self) private var vm
	var body: some View {
		VStack {
			ScrollView(.horizontal) {
				HStack(spacing: 18) {
					ForEach(ExploreOptions.allCases) { option in
						Button {
							vm.changeSelectedOption(to: option)
						} label: {
							Text(option.rawValue)
								.padding(.vertical, 10)
								.padding(.horizontal, 20)
								.background(vm.selectedExploreOption == option ? .primaryBlue : Color.gray.opacity(0.2))
								.foregroundColor(vm.selectedExploreOption == option ? .primaryWhite : .primaryBlue)
								.clipShape(RoundedRectangle(cornerRadius: 12))
								.shadow(color: vm.selectedExploreOption == option ? .primaryBlue.opacity(0.5) : .clear, radius: 5, x: 0, y: 5)
						}
						.accessibilityLabel("\(option.rawValue) option")
						.accessibilityHint("Tap to explore categories in the \(option.rawValue) option")
					}
				}
				.padding(.horizontal)
			}
			.padding(.vertical, 10)
			.background(Color(.systemGray6))
			.clipShape(RoundedRectangle(cornerRadius: 12))
			.padding()
		}
	}
}

#Preview {
	SubmenuExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
