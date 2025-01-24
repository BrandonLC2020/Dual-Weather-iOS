//
//  WeatherKitManager.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/24/25.
//

import Foundation
import WeatherKit
import JWTKit

struct WeatherKitAuth {
    private let keyID = "YOUR_KEY_ID"
    private let teamID = "YOUR_TEAM_ID"
    private let serviceID = "com.apple.weatherkit"
    private let privateKeyPath = URL(fileURLWithPath: "~/keys/WeatherKitKey.p8").standardizedFileURL

    func generateJWT() throws -> String {
        let privateKeyData = try Data(contentsOf: privateKeyPath)
        let signer = try JWTSigner.es256(key: .private(pem: privateKeyData))

        let claims = JWTClaims(
            iss: teamID,
            iat: Date(),
            exp: Date().addingTimeInterval(60 * 60), // Token valid for 1 hour
            sub: serviceID
        )

        let jwt = try signer.sign(claims)
        return jwt
    }
}

struct JWTClaims: JWTPayload {
    let iss: String // Team ID
    let iat: Date   // Issued At
    let exp: Date   // Expiration
    let sub: String // Service ID
}

@MainActor
func fetchWeather() async {
    do {
        let auth = WeatherKitAuth()
        let jwt = try auth.generateJWT()

        let weatherService = WeatherService(jwt: jwt)
        let location = CLLocation(latitude: 37.7749, longitude: -122.4194) // Example: San Francisco
        let weather = try await weatherService.weather(for: location)

        print("Temperature: \(weather.currentWeather.temperature)")
        print("Condition: \(weather.currentWeather.condition.description)")
    } catch {
        print("Error fetching weather: \(error)")
    }
}

