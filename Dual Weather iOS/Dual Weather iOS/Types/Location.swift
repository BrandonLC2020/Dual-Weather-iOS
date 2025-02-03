//
//  Location.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

import Foundation

struct Location: Codable, Hashable {
    let city: String
    let state: String
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case lat, lon
    }

    // Custom initializer for decoding from JSON
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let displayName = try values.decode(String.self, forKey: .displayName)
        let latString = try? values.decode(String.self, forKey: .lat)
        let lonString = try? values.decode(String.self, forKey: .lon)

        let components = displayName.components(separatedBy: ", ")
        self.city = components.first ?? "Unknown City"
        self.state = components.dropFirst().dropFirst().first ?? "Unknown State"
        self.latitude = latString.flatMap(Double.init)
        self.longitude = lonString.flatMap(Double.init)
    }

    // Encoding function to conform to `Encodable`
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let displayName = "\(city), \(state)"
        try container.encode(displayName, forKey: .displayName)
        
        if let latitude = latitude {
            try container.encode(String(latitude), forKey: .lat)
        }
        
        if let longitude = longitude {
            try container.encode(String(longitude), forKey: .lon)
        }
    }

    init(city: String, state: String, latitude: Double? = nil, longitude: Double? = nil) {
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
    }

    init?(document: [String: Any]) {
        guard let city = document["city"] as? String,
              let state = document["state"] as? String else { return nil }

        self.city = city
        self.state = state
        self.latitude = document["latitude"] as? Double
        self.longitude = document["longitude"] as? Double
    }

    func locationString() -> String {
        return "\(city), \(state)"
    }
}
