//
//  EditingMangaInCollectionSheetView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 4/1/25.
//

import SwiftUI

struct EditingMangaInCollectionSheetView: View {
	
	@Environment(\.dismiss) private var dismiss
	@Environment(MyCollectionViewModel.self) private var myCollectionVM

	@Bindable var vm: MyCollectionEditViewModel
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
	EditingMangaInCollectionSheetView(vm: MyCollectionEditViewModel())
		.environment(MyCollectionViewModel(repository: RepositoryLocalPreview()))
}
