//
//  HomeView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI
@preconcurrency import WeatherKit
import CoreLocation

// WeatherViewModel.swift
class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    @Published var locationError: String?
    @Published var isLocationAccessGranted: Bool = false

    private let weatherService = WeatherService()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // This function requests the user's location permission
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            // Request location authorization first
            locationManager.requestWhenInUseAuthorization()
        } else {
            // Location services are disabled, handle the error on the main thread
            DispatchQueue.main.async {
                self.locationError = "Location services are disabled."
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Check if permission is granted and start location updates
        DispatchQueue.main.async {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                // Start updating location only after authorization is granted
                self.locationManager.startUpdatingLocation()
            case .denied, .restricted:
                self.locationError = "Location access denied. Please enable location access in Settings."
            case .notDetermined:
                self.locationError = "Location permission is required to fetch weather."
            @unknown default:
                self.locationError = "Unknown location authorization status."
            }
        }
    }
    
    // CLLocationManagerDelegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            Task {
                await fetchWeather(for: location)
            }
            locationManager.stopUpdatingLocation()  // Stop updating location once we have it
        }
    }

    // Handle errors when failing to get the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = "Failed to find location: \(error.localizedDescription)"
    }

    // Fetch weather data for the provided location
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            
            // Dispatch the UI updates to the main thread only for the @Published properties
            await MainActor.run {
                self.currentWeather = weather
            }
        } catch {
            // Dispatch error updates to the main thread
            await MainActor.run {
                self.locationError = "Failed to fetch weather: \(error.localizedDescription)"
            }
        }
    }
}

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if let weather = viewModel.currentWeather {
                Text("Temperature: \(weather.currentWeather.temperature.value, specifier: "%.1f")°")
            } else if let error = viewModel.locationError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("Fetching weather...")
            }
        }
        .onAppear {
            viewModel.requestLocation() // Request location when view appears
        }
    }
}

#Preview {
    HomeView()
}
