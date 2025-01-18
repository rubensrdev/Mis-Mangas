//
//  MangaRemoveAlert.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 18/1/25.
//

import SwiftUI

struct MangaRemoveAlert: View {
	
	let mangaTitle: String
	let isPresented: Binding<Bool>
	let onRemove: () -> Void
	
	var body: some View {
		EmptyView()
			.alert("Remove \(mangaTitle) from your collection", isPresented: isPresented) {
				Button(role: .cancel) {} label: { Text("Cancel") }
				Button(role: .destructive) {
					onRemove()
				} label: {
					Text("Remove")
				}

			}
	}
}
