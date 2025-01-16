//
//  ProgressView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI

extension ProgressView {
	func withStyle() -> some View {
		self
			.tint(.primaryBlue)
			.scaleEffect(1.5)
			.padding(.vertical, 20)
	}
}
