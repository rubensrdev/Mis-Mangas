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
					.accessibilityLabel("Cancel removal")
					.accessibilityHint("Tap to cancel removing \(mangaTitle) from your collection")
				Button(role: .destructive) {
					onRemove()
				} label: {
					Text("Remove")
				}
				.accessibilityLabel("Confirm removal")
				.accessibilityHint("Tap to remove \(mangaTitle) from your collection")
			}
	}
}
