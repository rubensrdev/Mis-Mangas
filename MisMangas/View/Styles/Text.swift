//
//  Text.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension Text {
	
	/// Estilo para mostrar títulos de mangas en listas y cuadrículas.
	func mangaTitleStyle() -> some View {
		self
			.font(.headline)
			.foregroundStyle(.primaryDark)
			.multilineTextAlignment(.center)
			.lineLimit(2)
			.padding(.horizontal, 5)
	}
	
	/// Estilo para mostrar mensajes en un toast.
	func toastStyle() -> some View {
		self
			.padding()
			.background(.primaryBlue.opacity(0.8))
			.foregroundColor(.primaryWhite)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.padding(.bottom, 20)
	}
	
	/// Estilo para los títulos de las secciones principales.
	func headerSecTitleStyle() -> some View {
		self
			.font(.animeAceFont)
			.bold()
			.foregroundStyle(.primaryBlue)
	}
	
	/// Estilo para los subtítulos de las secciones principales.
	func headerSecSubtitleStyle() -> some View {
		self
			.font(.subheadline)
			.foregroundStyle(.secondary)
	}
	
	/// Estilo para mostrar puntuaciones.
	func scoreStyle() -> some View {
		self
			.font(.subheadline)
			.padding(.vertical, 5)
			.padding(.horizontal, 10)
			.background(
				Circle()
					.fill(LinearGradient(colors: [.primaryBlue, .secondaryYellow, .tertiaryPink], startPoint: .leading, endPoint: .trailing))
					
					
			)
			.foregroundStyle(.primaryDark)
	}
	
	/// Estilo para mostrar elementos seleccionados en una categoría de filtros.
	func selectedItemsInCategoryStyle() -> some View {
		self
			.lineLimit(2)
			.font(.footnote)
			.foregroundStyle(.secondary)
	}
}
