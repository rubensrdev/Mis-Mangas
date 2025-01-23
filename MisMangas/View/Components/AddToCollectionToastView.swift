//
//  AddToCollectionToastView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//

import SwiftUI

struct AddToCollectionToastView: View {
	
	let showToast: Bool
	let mangaNameAdded: String
	let shouldOffset: Bool
	
    var body: some View {
		if showToast {
			VStack {
				Spacer()
				Text("\(mangaNameAdded) has been added to your collection.")
					.toastStyle()
					.transition(.move(edge: .bottom).combined(with: .opacity))
					.animation(.easeInOut(duration: 0.5), value: showToast)
					.offset(y: shouldOffset ? -100 : 0)
			}
		}
    }
}

#Preview {
	AddToCollectionToastView(showToast: true, mangaNameAdded: "Dragon Ball", shouldOffset: false)
}
