//
//  MapThumbnail.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

import SwiftUI
import MapKit

class MapThumbnailGenerator {
    static func generateThumbnail(for coordinate: CLLocationCoordinate2D, size: CGSize, completion: @escaping (UIImage?) -> Void) {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        options.size = size
        options.mapType = .standard

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }

            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            snapshot.image.draw(at: .zero)

            // Draw pin
            let pinView = MKMarkerAnnotationView(annotation: nil, reuseIdentifier: nil)
            let pinImage = pinView.image
            let point = snapshot.point(for: coordinate)

            if let pinImage = pinImage {
                let pinCenterOffset = CGPoint(x: pinImage.size.width / 2, y: pinImage.size.height)
                let pinOrigin = CGPoint(x: point.x - pinCenterOffset.x, y: point.y - pinCenterOffset.y)
                pinImage.draw(at: pinOrigin)
            }

            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            completion(finalImage)
        }
    }
}

struct MapThumbnailView: View {
    let coordinate: CLLocationCoordinate2D
    let size: CGSize

    @State private var thumbnail: UIImage? = nil

    var body: some View {
        Group {
            if let image = thumbnail {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
            } else {
                ProgressView() // Show a loading indicator while generating the map
                    .frame(width: size.width, height: size.height)
            }
        }
        .onAppear {
            MapThumbnailGenerator.generateThumbnail(for: coordinate, size: size) { image in
                DispatchQueue.main.async {
                    self.thumbnail = image
                }
            }
        }
    }
}
