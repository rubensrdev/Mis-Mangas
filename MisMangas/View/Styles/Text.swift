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
			.multilineTextAlignment(.center)
			.lineLimit(2).frame(width: 120)
	}
}
