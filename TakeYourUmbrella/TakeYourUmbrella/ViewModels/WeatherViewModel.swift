//
//  ContentViewModel.swift
//  TakeYourUmbrella
//
//  Created by Anna on 21.03.2024.
//

import Foundation
import UserNotifications

final class WeatherViewModel: ObservableObject {
    
    @Published var weather: WeatherData? = nil
    @Published var chooseLocation: String = ""
    
    private let weatherService = WeatherService()
    let notifications: Notifications = Notifications()
    
    @MainActor func fetchWeather(weatherSearchParameters: WeatherSerachParameters) {
        Task {
            let weatherData = try? await weatherService.fetch(parameters: weatherSearchParameters)
            if weatherData != nil {
                self.weather = WeatherData(weather: weatherData!)
            }
        }
    }
    
}
