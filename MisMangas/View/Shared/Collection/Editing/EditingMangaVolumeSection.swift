//
//  EditingMangaVolumeSection.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//
import SwiftUI

/// Vista que representa una sección editable para ingresar valores relacionados con volúmenes de un manga.
///
/// - Uso:
///   Diseñada para ser utilizada en formularios de edición de mangas en la colección del usuario.
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
				.accessibilityHint("Enter the number of \(title.lowercased())")
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
