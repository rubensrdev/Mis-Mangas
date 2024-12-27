//
//  Image.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 27/12/24.
//

import SwiftUI

extension Image {
	func mangaGridImgStyle() -> some View {
		self
			.resizable()
			.scaledToFit()
			.frame(width: 120, height: 160)
			.cornerRadius(10)
			.shadow(radius: 6)
	}
}
