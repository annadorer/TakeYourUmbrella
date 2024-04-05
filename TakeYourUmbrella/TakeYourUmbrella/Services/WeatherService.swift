//
//  WeatherService.swift
//  TakeYourUmbrella
//
//  Created by Anna on 20.03.2024.
//

import Foundation

struct WeatherService {
    
    private let apiKey: String = "ff725df2c6d146c2ac791418242603"
    
    func fetch(for city: String) async throws -> Weather  {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&aqi=no") else { throw NSError() }
        let response = try await URLSession.shared.data(from: url)
        let weather = try JSONDecoder().decode(Weather.self, from: response.0)
        return weather
    }
}
