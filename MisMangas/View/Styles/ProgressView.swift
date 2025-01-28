//
//  ProgressView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension ProgressView {
	
	/// Estilo para loaders generales utilizados en la aplicación.
	func withStyle() -> some View {
		self
			.tint(.primaryBlue)
			.scaleEffect(1.5)
			.padding(.vertical, 20)
	}
	
	/// Estilo para barras de progreso relacionadas con el estado de mangas en la colección.
	func statusInCollectionStyle() -> some View {
		self
			.frame(width: 150)
	}
}
