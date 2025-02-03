//
//  SearchCard.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/3/25.
//

import SwiftUI
import MapKit

struct SearchCard: View {
    var location: Location
    @State private var coordinate: CLLocationCoordinate2D? // To store fetched coordinates
    @State private var errorMessage: String? // To handle errors
    
    let maxHeight: CGFloat = 100
    let maxWidth: CGFloat = 600


    var body: some View {
        HStack {
            if let coordinate = coordinate {
                MapThumbnailView(coordinate: coordinate, size: CGSize(width: 80, height: 80)).padding(.all, 10)
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            } else {
                ProgressView("Loading...")
                    .frame(width: 130, height: 130) // Placeholder while loading coordinates
            }
            
            Text(location.locationString())
                .lineLimit(1)
            Spacer()

        }
        .padding()
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .onAppear {
            if let lat = location.latitude, let lon = location.longitude {
                coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            } else {
                fetchCoordinates()
            }
        }
    }
    
    private func fetchCoordinates() {
        LocationService.shared.getCoordinates(forCity: location.city, state: location.state) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCoordinate):
                    coordinate = fetchedCoordinate
                    errorMessage = nil
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    SearchCard(location: Location(city: "West Lafayette", state: "IN"))
}
