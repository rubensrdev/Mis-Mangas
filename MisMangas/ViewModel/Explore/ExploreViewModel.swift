//
//  ExploreViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 14/1/25.
//

import Foundation



/// ViewModel que gestiona la lógica de la vista "Explore", permitiendo al usuario explorar mangas por categorías como autores,
/// demografías, géneros, temáticas y mangas mejor valorados.
///
/// - Uso:
///   Este ViewModel maneja la carga de datos, la paginación, y el estado de los elementos seleccionados en la vista de exploración.
@Observable
final class ExploreViewModel {
	
	/// Repositorio remoto utilizado para obtener los datos de exploración.
	let repository: RepositoryRemoteProtocol
	
	/// Lista de mangas actualmente cargados.
	var mangas: [Manga] = []
	
	/// Lista de autores cargados.
	var authors: [Author] = []
	
	/// Lista de demografías cargadas
	var demographics: [String] = []
	
	/// Lista de géneros cargados.
	var genres: [String] = []
	
	/// Lista de temáticas cargadas.
	var themes: [String] = []
	
	/// Número de elementos por página.
	let perPage = 100
	
	/// Página actual para la paginación.
	var page = 1
	
	/// Indica si se debe mostrar una alerta de error.
	var showErrorAlert = false
	
	/// Mensaje de error que se muestra en caso de fallo.
	var errorMessage = ""
	
	/// Lista completa de autores cargados desde el servidor.
	var allAuthors: [Author] = []
	
	/// Número de autores simulados por página.
	var authorSimulatedPerPage = 40
	
	/// Página actual para la simulación de autores.
	var authorSimulatedPage = 1
	
	/// Número total de autores disponibles.
	var totalAuthors = 0
	
	/// Indica si se están cargando más autores.
	var isLoadingMoreAuthors = false
	
	/// Opción de exploración seleccionada actualmente.
	var selectedExploreOption: ExploreOptions = .bestMangas
	
	/// Número total de mangas disponibles en la consulta actual.
	private var totalItems = 0
	
	/// Lista de mangas filtrados según la opción seleccionada.
	var mangasForOption: [Manga] = []
	
	/// Indica si se están cargando mangas para la opción seleccionada.
	var isLoadingMangasForOption = false
	
	/// Página actual para la opción seleccionada.
	var pageForOption = 1
	
	/// Número de elementos por página para la opción seleccionada.
	var perPageForOption = 40
	
	/// Número total de mangas disponibles para la opción seleccionada.
	var totalItemsForOption = 0
	
	init(repository: RepositoryRemoteProtocol = RepositoryRemote()) {
		self.repository = repository
	}
	
	/// Carga la lista completa de autores desde el repositorio remoto.
	@MainActor
	func loadAuthors() async {
		guard allAuthors.isEmpty else { return }
		do {
			let response = try await repository.getAuthors()
			allAuthors = response
			authors = Array(allAuthors.prefix(perPage))
			totalAuthors = allAuthors.count
		} catch {
			errorMessage = "Error loading authors"
			showErrorAlert = true
		}
	}
	
	/// Verifica si se necesitan cargar más autores y los carga si es necesario.
	@MainActor
	func checkAndLoadMoreAuthors(current: Author) {
		guard current == authors.last else { return }
		loadMoreAuthors()
	}
	
	/// Carga más autores desde la lista completa simulada.
	@MainActor
	func loadMoreAuthors() {
		guard !isLoadingMoreAuthors, authors.count < totalAuthors else { return }
		isLoadingMoreAuthors = true
		let currentCount = authors.count
		let newCount = min(currentCount + perPage, totalAuthors)
		authors = Array(allAuthors.prefix(newCount))
		isLoadingMoreAuthors = false
	}
	
	/// Cambia la opción seleccionada en la vista de exploración.
	func changeSelectedOption(to option: ExploreOptions) {
		selectedExploreOption = option
	}
	
	/// Carga los datos relacionados con la opción seleccionada.
	@MainActor
	func loadForSelectedOption() async {
		do {
			switch selectedExploreOption {
				case .bestMangas:
					let response = try await repository.getBestMangas(page: "\(page)", itemsPerPage: "\(perPage)")
					let filteredMangas = response.items.filter { manga in
						!mangas.contains { $0.id == manga.id }
					}
					mangas.append(contentsOf: filteredMangas)
					totalItems = response.metadata.total
				case .authors:
					if allAuthors.isEmpty {
						await loadAuthors()
					}
				case .demographics:
					let response = try await repository.getDemographics()
					guard !response.isEmpty else { return }
					let filteredDemographics = response.filter { demographic in
						!demographics.contains(demographic)
					}
					demographics.append(contentsOf: filteredDemographics)
				case .genres:
					let response = try await repository.getGenres()
					guard !response.isEmpty else { return }
					let filteredGenres = response.filter { genre in
						!genres.contains(genre)
					}
					genres.append(contentsOf: filteredGenres)
				case .themes:
					let response = try await repository.getThemes()
					guard !response.isEmpty else { return }
					let filteredThemes = response.filter { theme in
						!themes.contains(theme)
					}
					themes.append(contentsOf: filteredThemes)
			}
		} catch let error as NetworkError {
			errorMessage = error.errorDescription ?? "An unexpected network error occurred, try refreshing the screen"
			showErrorAlert = true
			print(error)
		} catch {
			errorMessage = "An error occurred while loading the manga, try refreshing the screen"
			showErrorAlert = true
			print(error)
		}
	}
	
	/// Realiza una búsqueda de mangas para la opción seleccionada.
	@MainActor
	func searchMangasFor(_ option: ExploreOptions, _ selected: String, _ page: String, _ perPage: String) async throws -> PaginatedMangaResponse? {
		do {
			switch option {
				case .demographics:
					return try await repository.getMangasByDemographic(selected, page: page, itemsPerPage: perPage)
				case .genres:
					return try await repository.getMangasByGenres(selected, page: page, itemsPerPage: perPage)
				case .themes:
					return try await repository.getMangasByThemes(selected, page: page, itemsPerPage: perPage)
				default:
					return nil
			}
		} catch {
			errorMessage = "Failed to load mangas for \(selected) in \(option.rawValue)"
			showErrorAlert = true
			return nil
		}
	}
	
	/// Resetea el estado relacionado con la opción seleccionada.
	func resetStateForOption() {
		mangasForOption.removeAll()
		isLoadingMangasForOption = false
		pageForOption = 1
		totalItemsForOption = 0
	}

	/// Carga mangas para la opción seleccionada con los filtros especificados.
	@MainActor
	func loadMangasForSelectedOption(_ option: ExploreOptions, selected: String) async {
		if pageForOption == 1 {
			resetStateForOption()
		}
		guard !isLoadingMangasForOption else { return }
		isLoadingMangasForOption = true
		do {
			let response = try await searchMangasFor(option, selected, "\(pageForOption)", "\(perPageForOption)")
			if let response = response {
				let mangas = response.items.filter { manga in
					!mangasForOption.contains { $0.id == manga.id }
				}
				mangasForOption.append(contentsOf: mangas)
				totalItemsForOption = response.metadata.total
				pageForOption += 1
			}
		} catch {
			errorMessage = "Failed to load mangas for \(selected) in \(option.rawValue)"
			showErrorAlert = true
		}
		isLoadingMangasForOption = false
	}
	
	/// Verifica si es necesario cargar más mangas para la opción seleccionada y los carga si es necesario.
	private func hasMorePages() -> Bool {
		mangasForOption.count < totalItemsForOption
	}
	
	/// Determina si hay más páginas disponibles para la opción seleccionada.
	@MainActor
	func loadMoreMangasIfNeeded(for id: Int, _ option: ExploreOptions, _ selected: String) async {
		guard !isLoadingMangasForOption, mangasForOption.last?.id == id, mangasForOption.count < totalItemsForOption, hasMorePages() else { return }
		await loadMangasForSelectedOption(option, selected: selected)
	}
	
}
