//
//  HomeView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI
import WeatherKit
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Weather?

    let weatherService = WeatherService()

    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            currentWeather = weather
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
}

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if let weather = viewModel.currentWeather {
                Text("Temperature: \(weather.currentWeather.temperature.value, specifier: "%.1f")°")
            } else {
                Text("Fetching weather...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeather(for: CLLocation(latitude: 37.7749, longitude: -122.4194)) // San Francisco
            }
        }
    }
}

#Preview {
    HomeView()
}
