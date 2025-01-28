//
//  AuthorRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

/// Vista que representa una fila con la información de un autor, mostrando su nombre completo y su rol.
///
/// - Uso:
///   Diseñada para ser utilizada en listas dentro de las vistas de exploración, específicamente en la sección de autores.
struct AuthorRow: View {
	let author: Author
	var body: some View {
		VStack(alignment: .leading) {
			Text(author.fullName)
				.font(.headline)
				.accessibilityLabel("Author: \(author.fullName)")
			Text(author.role)
				.font(.subheadline)
				.foregroundStyle(.secondary)
				.accessibilityLabel("Role: \(author.role)")
		}
		.padding()
	}
}

#Preview {
	AuthorRow(author: .preview)
}
