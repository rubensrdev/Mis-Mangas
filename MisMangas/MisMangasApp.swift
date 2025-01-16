//
//  MisMangasApp.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 24/12/24.
//

import SwiftUI

@MainActor let isIPad = UIDevice.current.userInterfaceIdiom == .pad

@main
struct MisMangasApp: App {
	
	@State var mangasVM = MangasViewModel()
	@State var myCollectionVM = MyCollectionViewModel()
	@State var exploreVM = ExploreViewModel()
	
    var body: some Scene {
        WindowGroup {
			if isIPad {
				EntryViewIPad()
					.environment(mangasVM)
					.environment(myCollectionVM)
					.environment(exploreVM)
			} else {
				EntryViewIPhone()
					.environment(mangasVM)
					.environment(myCollectionVM)
					.environment(exploreVM)
			}
        }
    }
}
