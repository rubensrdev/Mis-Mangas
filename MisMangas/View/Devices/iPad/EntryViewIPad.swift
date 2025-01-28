//
//  EntryViewIPad.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//

import SwiftUI


/// Vista principal para iPad que utiliza una barra de pestañas (`TabView`) para navegar
/// entre las secciones principales de la aplicación: Mangas, Explorar y Colección.
///
/// - Uso:
///   Presenta una interfaz optimizada para pantallas grandes, con vistas específicas para iPad en cada sección.
struct EntryViewIPad: View {
    var body: some View {
		TabView {
			MangasViewIPad()
				.tabItem {
					Label("Mangas", systemImage: "book.fill")
				}
			ExploreViewIpad()
				.tabItem {
					Label("Explore", systemImage: "square.grid.2x2.fill")
				}
			CollectionViewIPad()
				.tabItem {
					Label("Collection", systemImage: "rectangle.stack.fill")
				}
		}
		.tint(.primaryBlue)
    }
}

#Preview {
	EntryViewIPad()
		.environment(MangasViewModel(repository: RepositoryRemotePreview()))
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
		.environment(ExploreViewModel(repository: RepositoryRemotePreview()))
}
