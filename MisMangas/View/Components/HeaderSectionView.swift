//
//  HeaderSectionView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

/// Vista que muestra un encabezado con un título y un subtítulo para secciones.
///
/// - Uso:
///   Diseñada para ser utilizada como encabezado en diferentes secciones de la aplicación,
///   proporcionando un diseño consistente para títulos y subtítulos.
struct HeaderSectionView: View {
	let title: String
	let subtitle: String
	
	var body: some View {
		Section {
			VStack(alignment: .leading, spacing: 4) {
				Text(title)
					.headerSecTitleStyle()
				Text(subtitle)
					.headerSecSubtitleStyle()
			}
			.padding(.vertical, 8)
			.accessibilityLabel("\(title). \(subtitle)")
			.accessibilityHint("Header section title and subtitle")
		}
	}
}

#Preview {
	HeaderSectionView(title: "Best Mangas", subtitle: "A selection of the 100 best rated")
}
