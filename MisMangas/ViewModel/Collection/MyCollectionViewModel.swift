//
//  MyCollectionViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 3/1/25.
//

import Foundation

/// ViewModel que gestiona la lógica de negocio y el estado de la colección local de mangas del usuario.
///
/// - Uso:
///   Este ViewModel permite al usuario agregar, eliminar y editar mangas en su colección, además de aplicar filtros
///   y ordenaciones. Se conecta a un repositorio local para almacenar y recuperar los datos de la colección.
@Observable
final class MyCollectionViewModel {
	
	/// Repositorio local utilizado para gestionar los datos de la colección.
	private let repository: RepositoryLocalProtocol
	
	/// Indica si se debe mostrar una alerta de error.
	var showErrorAlert = false
	
	/// Mensaje de error mostrado en la alerta.
	var errorMessage = ""
	
	/// Indica si se debe mostrar un toast al agregar un manga.
	var showToast = false
	
	/// Título del manga agregado, mostrado en el toast.
	var addedMangaTitle = ""
	
	/// Indica si se debe mostrar una alerta para confirmar la eliminación de un manga.
	var showRemoveAlert = false
	
	/// Título del manga a eliminar, mostrado en la alerta.
	var removedMangaTitle = ""
	
	/// Manga seleccionado para ser eliminado.
	var mangaToRemove: MangaInCollection?
	
	/// Indica si se debe mostrar la hoja de edición.
	var showEditingSheet = false
	
	/// Texto de búsqueda para filtrar mangas en la colección.
	var searchText = ""
	
	/// Opción de ordenación seleccionada para los mangas en la colección.
	var orderOption = OrderOptions.byTitle
	
	/// Lista de mangas filtrados y ordenados según el texto de búsqueda y la opción de ordenación.
	var filteredMangas: [MangaInCollection] {
		mangas.filter { manga in
			searchText.isEmpty || manga.manga.title.localizedCaseInsensitiveContains(searchText)
		}
		.sorted { manga1, manga2 in
			switch orderOption {
				case .byTitle:
					manga1.manga.title < manga2.manga.title
				case .byCollecionComplete:
					manga1.completedCollection && !manga2.completedCollection
			}
		}
	}
	
	/// Lista de mangas en la colección del usuario.
	var mangas: [MangaInCollection]
	
	/// Indica si los mangas han sido cargados correctamente desde el repositorio local.
	var mangasAreLoaded = false
	
	init(repository: RepositoryLocalProtocol = RepositoryLocal()) {
		self.repository = repository
		do {
			mangas = try repository.loadMangasInCollection()
			mangasAreLoaded = true
		} catch {
			mangas = []
			mangasAreLoaded = true
			errorMessage = "Error loading mangas in collection: \(error)"
			showErrorAlert = true
		}
	}
	
	/// Verifica si un manga está en la colección.
	///
	/// - Parámetro:
	///   - `id`: Identificador del manga.
	func isInCollection(_ id: Int) -> Bool {
		mangas.contains(where: { $0.id == id })
	}
	
	/// Agrega un manga a la colección.
	///
	/// - Parámetro:
	///   - `manga`: Manga a agregar a la colección.
	@MainActor
	func addToCollection(_ manga: Manga) {
		guard !mangas.contains(where: { $0.id == manga.id }) else { return }
		mangas.append(manga.toMangaInCollection)
		saveMangas()
		addedMangaTitle = manga.title
		showToast = true
		Task {
			try await Task.sleep(for: .seconds(5))
			showToast = false
		}
	}
	
	/// Muestra una alerta para confirmar la eliminación de un manga.
	///
	/// - Parámetro:
	///   - `manga`: Manga a eliminar.
	func showRemoveAlert(for manga: MangaInCollection) {
		mangaToRemove = manga
		removedMangaTitle = manga.manga.title
		showRemoveAlert = true
	}
	
	/// Elimina un manga de la colección.
	///
	/// - Parámetro:
	///   - `manga`: Manga a eliminar de la colección.
	func removeFromCollection(_ manga: MangaInCollection) {
		mangas.removeAll() { $0.id == manga.id }
		saveMangas()
		removedMangaTitle = manga.manga.title
	}
	
	/// Actualiza un manga existente en la colección.
	///
	/// - Parámetro:
	///   - `mangaInCollection`: Manga con la información actualizada.
	func update(_ mangaInCollection: MangaInCollection) {
		if let index = mangas.firstIndex(where: { $0.id == mangaInCollection.id }) {
			mangas[index] = mangaInCollection
			saveMangas()
			
		}
	}
	
	/// Guarda los mangas en la colección local.
	func saveMangas() {
		try? repository.saveMangasInCollection(mangas)
	}
	
	/// Devuelve el estado de un manga específico en la colección.
	///
	/// - Parámetro:
	///   - `id`: Identificador del manga.
	func stateForManga(_ id: Int) -> MangaState {
		if !mangasAreLoaded {
			return .loading
		} else if isInCollection(id) {
			return .inCollection
		} else {
			return .notInCollection
		}
	}
}
