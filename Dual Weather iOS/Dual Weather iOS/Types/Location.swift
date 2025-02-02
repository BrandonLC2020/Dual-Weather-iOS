//
//  Location.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

struct Location: Codable {
    let city: String
    let state: String
    let latitude: Double?
    let longitude: Double?
    
    init(city: String, state: String, latitude: Double? = nil, longitude: Double? = nil) {
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(document: [String: Any]) {
        guard let city = document["city"] as? String,
              let state = document["state"] as? String else {
            return nil
        }
        
        self.city = city
        self.state = state
        self.latitude = document["latitude"] as? Double
        self.longitude = document["longitude"] as? Double
    }
    
    func locationString() -> String {
        return "\(city), \(state)"
    }
}
