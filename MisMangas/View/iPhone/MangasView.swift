//
//  MangasView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 26/12/24.
//

import SwiftUI

struct MangasView: View {
	
	@Environment(MangasViewModel.self) private var vm
	
    var body: some View {
		
		@Bindable var vm = vm
		
		List(vm.mangas) { manga in
			Text(manga.title)
		}
		.task {
			await vm.loadMangas()
		}
    }
}

#Preview {
    MangasView()
		.environment(MangasViewModel())
}
