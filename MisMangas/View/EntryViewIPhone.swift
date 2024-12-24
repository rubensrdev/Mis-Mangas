//
//  ContentView.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 24/12/24.
//

import SwiftUI

struct EntryViewIPhone: View {
    var body: some View {
        VStack {
            Image(systemName: "book.fill")
                .imageScale(.large)
			Text("Mis Mangas")
				.font(.title)
			Text("Proyecto SDP'24")
				.font(.headline)
        }
        .padding()
    }
}

#Preview {
    EntryViewIPhone()
}
