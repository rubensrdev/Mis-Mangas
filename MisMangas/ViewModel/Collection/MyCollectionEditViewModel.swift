//
//  MyCollectionEditViewModel.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import Foundation

@Observable
final class MyCollectionEditViewModel {
	
	let mangaInCollection: MangaInCollection
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
	
	var currentlyOwned: String {
		"Owned Volumes: \(volumesOwned)"
	}
	var currentlyReading: String {
		guard let totalVolumes = mangaInCollection.manga.volumes else { return "Currently Reading Volume: \(readingVolume) of unfinished manga" }
		return "Currently Reading Volume: \(readingVolume) of \(totalVolumes) volumes."
	}
	
	var showAlert = false
	var errorMessage = ""
	
	init(mangaInCollection: MangaInCollection) {
		self.mangaInCollection = mangaInCollection
		self.volumesOwned = mangaInCollection.volumesOwned
		self.readingVolume = mangaInCollection.readingVolume
	}
	
	func validate() -> MangaInCollection? {
		return mangaInCollection
	}
	
}
