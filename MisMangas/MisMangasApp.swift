//
//  MisMangasApp.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 24/12/24.
//

import SwiftUI

@main
struct MisMangasApp: App {
	
	@State var mangasVM = MangasViewModel()
	@State var myCollectionVM = MyCollectionViewModel()
	@State var exploreVM = ExploreViewModel()
	
    var body: some Scene {
        WindowGroup {
            EntryViewIPhone()
				.environment(mangasVM)
				.environment(myCollectionVM)
				.environment(exploreVM)
        }
    }
}
