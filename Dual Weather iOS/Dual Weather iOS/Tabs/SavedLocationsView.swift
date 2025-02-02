//
//  SavedLocationsView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import MapKit

struct SavedLocationsView: View {
    @State private var locations: [Location] = [] // Array to store fetched locations
    @State private var isLoading = true           // Loading state
    @State private var errorMessage: String?      // Error message state

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if isLoading {
                    ProgressView("Loading locations...") // Loading indicator
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage) // Display error message if any
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(locations, id: \.city) { location in
                            LocationCard(location: location)
                                .padding()
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 3)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved Locations")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                fetchLocations()
            }
        }
    }

    // Fetch locations from Firestore
    private func fetchLocations() {
        isLoading = true
        errorMessage = nil

        DatabaseManager.shared.fetchLocations { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedLocations):
                    locations = fetchedLocations
                case .failure(let error):
                    errorMessage = "Failed to fetch locations: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    SavedLocationsView()
}
