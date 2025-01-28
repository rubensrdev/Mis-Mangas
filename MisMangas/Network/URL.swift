//
//  URL.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// URL base para las solicitudes manga del API
let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

extension URL {
	/// Construye una URL para obtener la lista de mangas paginada.
	///
	/// - Parámetros:
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la solicitud de mangas.
	static func mangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.listMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	/// Construye una URL para obtener mangas filtrados por temática.
	///
	/// - Parámetros:
	///   - theme: La temática por la que se desea filtrar.
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la solicitud de mangas por temática.
	static func mangasByThemes(_ theme: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByTheme.path)/\(theme)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	/// Construye una URL para obtener mangas filtrados por género.
	///
	/// - Parámetros:
	///   - genre: El género por el que se desea filtrar.
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la solicitud de mangas por género.
	static func mangasByGenres(_ genre: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByGenre.path)/\(genre)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	/// Construye una URL para obtener mangas filtrados por demografía.
	///
	/// - Parámetros:
	///   - demographic: La demografía por la que se desea filtrar.
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la solicitud de mangas por demografía.
	static func mangasByDemographic(_ demographic: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByDemographic.path)/\(demographic)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	/// Construye una URL para obtener la lista de los mangas mejor valorados.
	///
	/// - Parámetros:
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la solicitud de mangas mejor valorados.
	static func bestMangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.listBestMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	/// Construye una URL para obtener la lista de autores.
	///
	/// - Retorno: Una URL configurada para la solicitud de autores.
	static func authors() -> URL {
		mainURL
			.appending(path: Endpoints.listAuthors.path)
	}
	
	/// Construye una URL para obtener la lista de demografías.
	///
	/// - Retorno: Una URL configurada para la solicitud de demografías.
	static func demographics() -> URL {
		mainURL
			.appending(path: Endpoints.listDemographics.path)
	}
	
	/// Construye una URL para obtener la lista de géneros.
	///
	/// - Retorno: Una URL configurada para la solicitud de géneros.
	static func genres() -> URL {
		mainURL
			.appending(path: Endpoints.listGenres.path)
	}
	
	/// Construye una URL para obtener la lista de temáticas.
	///
	/// - Retorno: Una URL configurada para la solicitud de temáticas.
	static func themes() -> URL {
		mainURL
			.appending(path: Endpoints.listThemes.path)
	}
	
	/// Construye una URL para realizar búsquedas de mangas.
	///
	/// - Parámetros:
	///   - page: Número de la página a consultar.
	///   - itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Una URL configurada para la búsqueda de mangas.
	static func searchMangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.searchMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
}

extension URLQueryItem {
	/// Crea un parámetro de consulta para la paginación.
	///
	/// - Parámetro page: Número de la página.
	/// - Retorno: Un objeto `URLQueryItem` con el nombre "page" y el valor proporcionado.
	static func queryPage(page: String) -> URLQueryItem {
		URLQueryItem(name: "page", value: page)
	}
	
	/// Crea un parámetro de consulta para los elementos por página.
	///
	/// - Parámetro itemsPerPage: Cantidad de elementos por página.
	/// - Retorno: Un objeto `URLQueryItem` con el nombre "per" y el valor proporcionado.
	static func queryItemsPerPage(itemsPerPage: String) -> URLQueryItem {
		URLQueryItem(name: "per", value: itemsPerPage)
	}
}
