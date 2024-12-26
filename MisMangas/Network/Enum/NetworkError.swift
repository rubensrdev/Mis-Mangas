//
//  NetworkError.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import Foundation

/// Enumeración que define diferentes tipos de errores de red que pueden ocurrir durante la interacción con en red.
/// implementa `LocalizedError` para proporcionar descripciones legibles de los errores
/// - Cases:
///   - `dataNotValid`: Indica que los datos recibidos no son válidos.
///   - `nonHttp`: Señala que la respuesta no corresponde a un protocolo HTTP válido.
///   - `json(Error)`: Error relacionado con la codificación o decodificación de datos JSON.
///   - `status(Int)`: Error debido a un código de estado HTTP no exitoso.
///   - `unknown(Error)`: Representa un error desconocido, encapsulando el objeto de tipo `Error`.
enum NetworkError: LocalizedError {
	case dataNotValid
	case nonHttp
	case json(Error)
	case status(Int)
	case unknown(Error)
	
	var errorDescription: String? {
		switch self {
			case .dataNotValid:
				"Los datos recibidos no son válidos."
			case .nonHttp:
				"La respuesta no corresponde a un protocolo HTTP válido."
			case .json(let error):
				"Error de JSON: \(error)"
			case .status(let code):
				"Error de estado HTTP: \(code)"
			case .unknown(let error):
				"Error desconocido: \(error)"
		}
	}
}
