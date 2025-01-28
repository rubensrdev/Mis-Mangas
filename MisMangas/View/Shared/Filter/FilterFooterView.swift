//
//  FilterFooterView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

/// Vista que muestra un pie de formulario en la sección de filtros para proporcionar información adicional al usuario.
///
/// - Uso:
///   Diseñada para ser utilizada como el pie de una sección dentro del formulario de filtros, ofreciendo instrucciones o mensajes contextuales.
struct FilterFooterView: View {
	var body: some View {
		Section {
			EmptyView() // Si no hay contenido principal en la sección
		} footer: {
			Text("You can use these filters freely to fine-tune your search.")
				.font(.footnote)
				.fontWeight(.semibold)
		}
		.padding(.bottom)
	}
}

#Preview {
	FilterFooterView()
}
