//
//  MyCollectionEditViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import Foundation

/// ViewModel encargado de gestionar la lógica de edición de un manga en la colección del usuario.
///
/// - Uso:
///   Permite al usuario actualizar el número de volúmenes poseídos y el volumen que está leyendo de un manga específico.
///   Incluye validaciones para garantizar que los valores ingresados sean consistentes con los datos del manga.
@Observable
final class MyCollectionEditViewModel {
	
	/// Manga que se está editando en la colección.
	var mangaInCollection: MangaInCollection
	
	/// Número de volúmenes poseídos por el usuario.
	var volumesOwned: Int {
		didSet {
			if let volumes = mangaInCollection.manga.volumes {
				self.volumesOwned > volumes ? volumes : self.volumesOwned
			}
		}
	}
	
	/// Número del volumen que el usuario está leyendo actualmente.
	var readingVolume: Int {
		didSet {
			self.readingVolume > volumesOwned ? volumesOwned : self.readingVolume
		}
	}
	
	/// Indica si se debe mostrar una alerta de error.
	var showAlert = false
	
	/// Mensaje de error mostrado en la alerta.
	var errorMessage = ""
	
	init(mangaInCollection: MangaInCollection) {
		self.mangaInCollection = mangaInCollection
		self.volumesOwned = mangaInCollection.volumesOwned
		self.readingVolume = mangaInCollection.readingVolume
	}
	
	/// Valida que el número de volúmenes poseídos sea consistente.
	private func validateVolumesOwned() -> Bool {
		let totalVolumes = mangaInCollection.manga.volumes ?? Int.max
		return volumesOwned >= readingVolume && volumesOwned <= totalVolumes && volumesOwned >= 0
	}
	
	/// Valida que el volumen que se está leyendo sea consistente.
	private func validateReadingVolume() -> Bool {
		let totalVolumes = mangaInCollection.manga.volumes ?? Int.max
		return readingVolume <= totalVolumes  && readingVolume <= volumesOwned && readingVolume >= 0
	}
	
	/// Valida los datos ingresados y construye un objeto `MangaInCollection` si son válidos.
	func validate() -> MangaInCollection? {
		var errors = ""
		var errorCount = 0
		if !validateVolumesOwned() {
			errorCount += 1
			errors.append("\(errorCount) - \(String(localized: LocalizedStringResource("Validation_Owned"))).\n")
		}
		if !validateReadingVolume() {
			errorCount += 1
			errors.append("\(errorCount) - \(String(localized: LocalizedStringResource("Validation_Reading"))).\n")
		}
		if errorCount > 0 {
			showAlert.toggle()
			errorMessage = errors
			return nil
		} else {
			return MangaInCollection(id: mangaInCollection.id, manga: mangaInCollection.manga, volumesOwned: volumesOwned, readingVolume: readingVolume)
		}
	}
	
}

extension MyCollectionEditViewModel {
	
	/// Texto descriptivo del número de volúmenes poseídos.
	var currentlyOwned: String {
		guard let totalVolumes = mangaInCollection.manga.volumes else { return "Owned Volumes: \(volumesOwned) of unfinished manga" }
		return "Owned Volumes: \(volumesOwned) of \(totalVolumes) volumes."
	}
	
	/// Texto descriptivo del volumen que se está leyendo.
	var currentlyReading: String {
		guard let totalVolumes = mangaInCollection.manga.volumes else { return "Currently Reading Volume: \(readingVolume) of unfinished manga" }
		return "Currently Reading Volume: \(readingVolume) of \(totalVolumes) volumes."
	}
}
