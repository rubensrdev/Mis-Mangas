//
//  AddToCollectionToastView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 23/1/25.
//

import SwiftUI


/// Vista que muestra un mensaje temporal (toast) indicando que un manga ha sido agregado a la colección.
///
/// - Uso:
///   Diseñada para ser utilizada en cualquier vista donde el usuario pueda agregar mangas a su colección.
///   El mensaje se muestra temporalmente y desaparece automáticamente.
///
/// - Propiedades:
///   - `showToast`: Indica si el toast debe mostrarse.
///   - `mangaNameAdded`: El nombre del manga que ha sido agregado.
///   - `shouldOffset`: Determina si el toast debe desplazarse hacia arriba.
struct AddToCollectionToastView: View {
	
	let showToast: Bool
	let mangaNameAdded: String
	let shouldOffset: Bool
	
    var body: some View {
		if showToast {
			VStack {
				Spacer()
				Text("\(mangaNameAdded) has been added to your collection")
					.toastStyle()
					.transition(.move(edge: .bottom).combined(with: .opacity))
					.animation(.easeInOut(duration: 0.5), value: showToast)
					.offset(y: shouldOffset ? -100 : 0)
					.accessibilityLabel("\(mangaNameAdded) added to your collection")
					.accessibilityHint("This message will disappear shortly")
			}
		}
    }
}

#Preview {
	AddToCollectionToastView(showToast: true, mangaNameAdded: "Dragon Ball", shouldOffset: false)
}
