//
//  MyCollectionEditViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import Foundation

@Observable
final class MyCollectionEditViewModel {
	
	var mangaInCollection: MangaInCollection
	
	var volumesOwned: Int {
		didSet {
			if let volumes = mangaInCollection.manga.volumes {
				self.volumesOwned > volumes ? volumes : self.volumesOwned
			}
		}
	}
	var readingVolume: Int {
		didSet {
			self.readingVolume > volumesOwned ? volumesOwned : self.readingVolume
		}
	}
	
	var showAlert = false
	var errorMessage = ""
	
	init(mangaInCollection: MangaInCollection) {
		self.mangaInCollection = mangaInCollection
		self.volumesOwned = mangaInCollection.volumesOwned
		self.readingVolume = mangaInCollection.readingVolume
	}
	
	private func validateVolumesOwned() -> Bool {
		let totalVolumes = mangaInCollection.manga.volumes ?? Int.max
		return volumesOwned >= readingVolume && volumesOwned <= totalVolumes && volumesOwned >= 0
	}
	
	private func validateReadingVolume() -> Bool {
		let totalVolumes = mangaInCollection.manga.volumes ?? Int.max
		return readingVolume <= totalVolumes  && readingVolume <= volumesOwned && readingVolume >= 0
	}
	
	func validate() -> MangaInCollection? {
		var errors = ""
		var errorCount = 0
		if !validateVolumesOwned() {
			errorCount += 1
			errors.append("\(errorCount) - You cannot have more volumes than exist or an amount greater than your current reading volume.\n")
		}
		if !validateReadingVolume() {
			errorCount += 1
			errors.append("\(errorCount) - Your read volume must be less than or equal to the total of published volumes and volumes you already own.\n")
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
	var currentlyOwned: String {
		"Owned Volumes: \(volumesOwned)"
	}
	var currentlyReading: String {
		guard let totalVolumes = mangaInCollection.manga.volumes else { return "Currently Reading Volume: \(readingVolume) of unfinished manga" }
		return "Currently Reading Volume: \(readingVolume) of \(totalVolumes) volumes."
	}
}
