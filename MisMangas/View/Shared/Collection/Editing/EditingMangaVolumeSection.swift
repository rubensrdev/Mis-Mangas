//
//  EditingMangaVolumeSection.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI

struct EditingMangaVolumeSection: View {
	let title: String
	let textFieldPlaceholder: String
	@Binding var value: Int
	let currentInfo: String
	var body: some View {
		Section {
			TextField(textFieldPlaceholder, value: $value, format: .number)
				.keyboardType(.numberPad)
				.padding(10)
			Text(currentInfo)
				.font(.footnote)
				.foregroundStyle(.secondary)
		} header: {
			Text(title)
				.font(.headline)
				.foregroundStyle(.primaryBlue)
		}
	}
}

#Preview {
	EditingMangaVolumeSection(title: "Volumes Owned", textFieldPlaceholder: "Enter volumes owned", value: .constant(17), currentInfo: "Owned volumes: \(17)")
}
