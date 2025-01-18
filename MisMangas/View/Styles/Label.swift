//
//  Label.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension Label {
	func notFoundStyle() -> some View {
		self
			.font(.headline)
			.foregroundStyle(Color.tertiaryPink)
			.padding()
			.background(Color.secondaryGray)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.padding()
	}
	
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
