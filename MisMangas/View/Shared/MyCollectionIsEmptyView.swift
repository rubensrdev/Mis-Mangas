//
//  MyCollectionIsEmptyView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 17/1/25.
//
import SwiftUI

struct MyCollectionIsEmptyView: View {
	var body: some View {
		VStack {
			Spacer()
			Image(systemName: "books.vertical")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
				.foregroundStyle(.secondaryGray)
			Text("Your collection is empty")
				.font(.headline)
				.foregroundStyle(.primaryDark)
			Spacer()
		}
	}
}

#Preview {
	MyCollectionIsEmptyView()
}
