//
//  LoadingMoreView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//
import SwiftUI

/// Vista que muestra un indicador de carga mientras se están cargando más mangas.
///
/// - Uso:
///   Diseñada para ser utilizada al final de listas o cuadrículas, indicando que se están cargando más resultados.
struct LoadingMoreView: View {
	var body: some View {
		VStack {
			ProgressView()
				.withStyle()
			Text("Loading more mangas...")
				.font(.footnote)
				.foregroundStyle(.secondaryGray)
				.accessibilityHint("Please wait while we load additional mangas")
		}
	}
}

#Preview {
	LoadingMoreView()
}
