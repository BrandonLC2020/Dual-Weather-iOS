//
//  LocationService.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

import Foundation
import CoreLocation

class LocationService {
    static let shared = LocationService() // Singleton instance
    private let geocoder = CLGeocoder()
    
    private init() {}
    
    /// Get coordinates for a given city and state
    /// - Parameters:
    ///   - city: The name of the city
    ///   - state: The name or abbreviation of the state
    ///   - completion: A closure that returns a result with coordinates or an error
    func getCoordinates(forCity city: String, state: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let locationString = "\(city), \(state)"
        
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Coordinates not found for \(locationString)."])))
                return
            }
            
            completion(.success(location.coordinate))
        }
    }
}
