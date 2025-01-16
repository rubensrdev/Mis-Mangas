//
//  DemographyRow.swift
//  MisMangas
//
//  Created by Rubén Segura Romo on 16/1/25.
//
import SwiftUI

struct DemographyRow: View {
	let demography: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(demography)
				.font(.headline)
		}
	}
}

#Preview {
	DemographyRow(demography: "Demography")
}
