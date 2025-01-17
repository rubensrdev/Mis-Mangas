//
//  FilterFooterView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

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
	
}
