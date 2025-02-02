//
//  Location.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 2/2/25.
//

struct Location: Codable {
    let city: String
    let state: String
    
    init(city: String, state: String) {
        self.city = city
        self.state = state
    }
    
    init?(document: [String: Any]) {
        guard let city = document["city"] as? String,
              let state = document["state"] as? String else {
            return nil
        }
        self.city = city
        self.state = state
    }
}
