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
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 6)
	}
	
	func mangaListImgStyle() -> some View {
		self
			.resizable()
			.scaledToFit()
			.frame(width: 60, height: 80)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 6)
	}
	
	func mangaGridImgStyleForIPad() -> some View {
		self
			.resizable()
			.scaledToFit()
			.frame(width: 200, height: 300)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 6)
	}
	
	func mangaListImgStyleforIpad() -> some View {
		self
			.resizable()
			.scaledToFit()
			.frame(width: 180, height: 200)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 6)
	}
}
