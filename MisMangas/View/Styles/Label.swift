//
//  Label.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension Label {
	
	/// Estilo para mensajes de elementos no encontrados.
	func notFoundStyle() -> some View {
		self
			.font(.headline)
			.foregroundStyle(Color.tertiaryPink)
			.padding()
			.background(Color.secondaryGray)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.padding()
	}
	
	/// Estilo para indicar que la colección está completa.
	func collectionCompletedStyle() -> some View {
		self
			.font(.footnote)
			.padding(10)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.fill(.tertiaryGreen.opacity(0.1))
			)
			.foregroundStyle(.tertiaryGreen)
	}
	
	/// Estilo para indicar que la colección no está completa.
	func collectionNotCompletedStyle() -> some View {
		self
			.font(.footnote)
			.padding(10)
			.background(
				RoundedRectangle(cornerRadius: 10)
					.fill(.red.opacity(0.1))
			)
			.foregroundStyle(.red)
	}
}
