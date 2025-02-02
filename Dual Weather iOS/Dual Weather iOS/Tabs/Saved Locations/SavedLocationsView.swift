//
//  SavedLocationsView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI
import MapKit

struct SavedLocationsView: View {

    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(locations) { location in
                    LocationCard(location: location)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                }
            }
            .padding()
        }
        .navigationTitle("Saved Locations")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    SavedLocationsView()
}
