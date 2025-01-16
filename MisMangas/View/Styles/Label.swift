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
			.cornerRadius(10)
			.padding()
	}
}
