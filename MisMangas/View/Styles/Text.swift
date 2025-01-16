//
//  Text.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension Text {
	func mangaTitleStyle() -> some View {
		self
			.font(.headline)
			.foregroundStyle(.primaryDark)
			.multilineTextAlignment(.center)
			.lineLimit(2)
			.padding(.horizontal, 5)
	}
	
	func toastStyle() -> some View {
		self
			.padding()
			.background(Color.primaryDark.opacity(0.8))
			.foregroundColor(.primaryWhite)
			.cornerRadius(10)
			.padding(.bottom, 20)
	}
	
	func exploreTitleStyle() -> some View {
		self
			.font(.largeTitle)
			.bold()
			.foregroundStyle(.primaryBlue)
	}
	
	func exploreSubtitleStyle() -> some View {
		self
			.font(.subheadline)
			.foregroundStyle(.secondary)
	}
	
	func scoreStyle() -> some View {
		self
			.font(.subheadline)
			.padding(.vertical, 5)
			.padding(.horizontal, 10)
			.background(
				Circle()
					.fill(LinearGradient(colors: [.primaryBlue, .secondaryYellow, .tertiaryPink], startPoint: .leading, endPoint: .trailing))
					
					
			)
			.foregroundStyle(.primaryDark)
	}
}
