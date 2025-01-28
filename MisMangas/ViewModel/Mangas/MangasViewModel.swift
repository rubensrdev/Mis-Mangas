//
//  MangasVM.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// ViewModel que gestiona la lógica de la vista de "Mangas"  y el estado relacionado con los mangas.
///
/// - Uso:
///   Permite cargar listas de mangas desde un repositorio remoto, gestionar paginación, búsqueda avanzada,
///   y manejar errores de red de forma eficiente.
@Observable
final class MangasViewModel {
	
	/// Repositorio remoto utilizado para obtener los datos de los mangas.
	let repository: RepositoryRemoteProtocol
	
	/// Respuesta paginada obtenida del repositorio remoto.
	var response: PaginatedMangaResponse?
	
	/// Lista de mangas actualmente cargados.
	var mangas: [Manga] = []
	
	/// Número de elementos por página.
	let perPage = 12
	
	/// Página actual para la paginación.
	var page = 1
	
	/// Indica si se debe mostrar una alerta de error.
	var showErrorAlert = false
	
	/// Mensaje de error que se muestra en caso de fallo.
	var errorMessage = ""
	
	/// Indica si los filtros están visibles.
	var showFilters = false
	
	/// Manga seleccionado actualmente.
	var selectedManga: Manga?
	
	/// Indica si se están cargando más mangas.
	var isLoadingMore = false
	
	/// Número total de mangas disponibles en la consulta actual.
	private var totalItems = 0
	
	/// Indica si actualmente se está realizando una búsqueda.
	var isSearching = false
	
	/// Criterios de búsqueda actuales.
	var searchCriteria: CustomSearch?
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	/// Carga la lista de mangas, aplicando paginación o criterios de búsqueda si están definidos.
	///
	/// - Marcado como `@MainActor` para asegurar que los cambios en las propiedades observables ocurran en el hilo principal.
	@MainActor
	func loadMangas() async {
		do {
			if isSearching, var searchCriteria = searchCriteria {
				if page == 1 {
					mangas.removeAll()
				}
				searchCriteria.page = "\(page)"
				searchCriteria.perPage = "\(perPage)"
				let response = try await repository.searchMangas(with: searchCriteria)
				self.response = response
				let filteredMangas = response.items.filter { manga in
					!mangas.contains { $0.id == manga.id } && manga.isValid
				}
				mangas.append(contentsOf: filteredMangas)
				totalItems = response.metadata.total
			} else {
				let response = try await repository.getMangas(page: "\(page)", itemsPerPage: "\(perPage)")
				self.response = response
				let filteredMangas = response.items.filter { manga in
					!mangas.contains { $0.id == manga.id } && manga.isValid
				}
				mangas.append(contentsOf: filteredMangas)
				totalItems = response.metadata.total
			}
		} catch let error as NetworkError {
			print(error)
			showErrorAlert = true
			errorMessage = error.errorDescription ?? "An unexpected network error occurred, try refreshing the screen"
			print(error)
		} catch {
			print(error)
			showErrorAlert = true
			errorMessage = "An error occurred while loading the manga, try refreshing the screen"
			print(error)
		}
	}
	
	/// Determina si el manga con el ID especificado es el último de la lista cargada.
	///
	/// - Parámetro:
	///   - `id`: Identificador del manga.
	private func isLast(id: Int) -> Bool {
		mangas.last?.id == id
	}
	
	/// Determina si hay más páginas disponibles para cargar.
	private func hasMorePages() -> Bool {
		mangas.count < totalItems
	}
	
	/// Carga más mangas si se cumplen las condiciones de paginación.
	 ///
	 /// - Parámetro:
	 ///   - `id`: Identificador del manga actual para determinar si es el último.
	@MainActor
	func loadMoreMangas(id: Int) {
		guard isLast(id: id), hasMorePages(), !isLoadingMore else { return }
		isLoadingMore = true
		page += 1
		Task {
			await loadMangas()
			isLoadingMore = false
		}
	}
	
	/// Inicia una búsqueda con los criterios especificados.
	///
	/// - Parámetro:
	///   - `criteria`: Objeto `CustomSearch` con los filtros de búsqueda.
	private func startSearch(with criteria: CustomSearch) {
		searchCriteria = criteria
		isSearching = true
		page = 1
	}
	
	/// Realiza una búsqueda con los criterios especificados y carga los resultados.
	///
	/// - Parámetro:
	///   - `criteria`: Objeto `CustomSearch` con los filtros de búsqueda.
	@MainActor
	func search(with criteria: CustomSearch) async {
		startSearch(with: criteria)
		await self.loadMangas()
	}
	
	/// Resetea los criterios de búsqueda y recarga los mangas.
	func resetSearch() {
		searchCriteria = nil
		isSearching = false
		page = 1
		mangas.removeAll()
	}
	
}
