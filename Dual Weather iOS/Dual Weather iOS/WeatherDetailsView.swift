//
//  WeatherDetailsView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct WeatherDetailsView: View {
    private var locationName: String
    @StateObject private var weatherViewModel = WeatherViewModel()

    // Initialize with locationName
    init(locationName: String) {
        self.locationName = locationName
    }

    var body: some View {
        NavigationView {
            VStack {
                if let currentWeather = weatherViewModel.currentWeather {
                    Text("Weather for \(locationName)")
                        .font(.title)
                        .padding()
                    
                    // Display temperature and additional details
                    Text("Temperature: \(currentWeather.currentWeather.temperature.description)")
                        .font(.headline)
                        .padding()
                    
                    Text("Condition: \(currentWeather.currentWeather.condition.description)")
                        .font(.subheadline)
                        .padding()
                    
                    Text("Wind: \(currentWeather.currentWeather.wind.speed.description)")
                        .font(.subheadline)
                        .padding()
                    
                    Text("Humidity: \(currentWeather.currentWeather.humidity.description)")
                        .font(.subheadline)
                        .padding()
                } else if let error = weatherViewModel.locationError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Text("Fetching weather for \(locationName)...")
                        .padding()
                }
            }
        }
        .navigationTitle("Current Weather")
        .onAppear {
            fetchWeatherForLocation()
        }
    }

    // Function to fetch weather for the location name
    private func fetchWeatherForLocation() {
        weatherViewModel.fetchCoordinates(from: locationName) { result in
            switch result {
            case .success(let location):
                Task {
                    await weatherViewModel.fetchWeather(for: location)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    weatherViewModel.locationError = "Failed to get coordinates: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    WeatherDetailsView(locationName: "San Francisco")
}
