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
	/// - Parameter page: El número de la página a consultar.
	/// - Returns: Una URL configurada para la solicitud de mangas.
	static func mangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.listMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	static func mangasByThemes(_ theme: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByTheme.path)/\(theme)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	static func mangasByGenres(_ genre: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByGenre.path)/\(genre)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	static func mangasByDemographic(_ demographic: String, page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: "\(Endpoints.listMangaByDemographic.path)/\(demographic)")
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	static func bestMangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.listBestMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
	
	static func authors() -> URL {
		mainURL
			.appending(path: Endpoints.listAuthors.path)
	}
	
	static func demographics() -> URL {
		mainURL
			.appending(path: Endpoints.listDemographics.path)
	}
	
	static func genres() -> URL {
		mainURL
			.appending(path: Endpoints.listGenres.path)
	}
	
	static func themes() -> URL {
		mainURL
			.appending(path: Endpoints.listThemes.path)
	}
	
	static func searchMangas(page: String, itemsPerPage: String) -> URL {
		mainURL
			.appending(path: Endpoints.searchMangas.path)
			.appending(queryItems: [.queryPage(page: page), .queryItemsPerPage(itemsPerPage: itemsPerPage)])
	}
}

extension URLQueryItem {
	/// Crea un parámetro de consulta para la paginación.
	///
	/// - Parameter page: El número de la página a consultar.
	/// - Returns: Un objeto `URLQueryItem` con el nombre "page" y el valor correspondiente.
	static func queryPage(page: String) -> URLQueryItem {
		URLQueryItem(name: "page", value: page)
	}
	
	static func queryItemsPerPage(itemsPerPage: String) -> URLQueryItem {
		URLQueryItem(name: "per", value: itemsPerPage)
	}
}
