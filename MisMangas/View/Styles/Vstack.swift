//
//  Vstack.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//

import SwiftUI

extension VStack {
	
	/// Estilo para filas de mangas en vistas de cuadrículas en iPhone.
	func mangaRowStyle() -> some View {
		self
			.padding()
			.frame(width: 150, height: 250)
			.background(Color.secondaryGray)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
	}
	
	/// Estilo para filas de mangas en vistas de cuadrículas en iPad.
	func mangaRowStyleIPad() -> some View {
		self
			.padding()
			.background(.secondaryGray)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
	}
	
	/// Estilo para secciones de detalle de mangas.
	func mangaDetailStyle() -> some View {
		self
			.padding()
			.background(Color.secondaryGray.opacity(0.3))
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}
