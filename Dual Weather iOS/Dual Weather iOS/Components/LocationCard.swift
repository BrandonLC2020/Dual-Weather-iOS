//
//  LocationCard.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

import SwiftUI
import MapKit

struct LocationCard: View {
    let exampleCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
    
    var body: some View {
        VStack {
            Text("Location Thumbnail")
                .font(.headline)
                .padding(.bottom, 5)
            
            MapThumbnailView(coordinate: exampleCoordinate, size: CGSize(width: 150, height: 150))
        }
        .padding()
    }
}

#Preview {
    LocationCard()
}
