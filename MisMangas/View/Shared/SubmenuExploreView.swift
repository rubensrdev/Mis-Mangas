//
//  SubmenuExploreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct SubmenuExploreView: View {
	@Environment(ExploreViewModel.self) private var vm
	var body: some View {
		VStack {
			Text("Select category")
				.font(.headline)
				.foregroundStyle(.primaryDark)
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
								.cornerRadius(12)
								.shadow(color: vm.selectedExploreOption == option ? .primaryBlue.opacity(0.5) : .clear, radius: 5, x: 0, y: 5)
						}
					}
				}
				.padding(.horizontal)
			}
			.padding(.vertical, 10)
			.background(Color(.systemGray6))
			.cornerRadius(15)
			.padding()
		}
	}
}

#Preview {
	SubmenuExploreView()
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
