//
//  Weather.swift
//  TakeYourUmbrella
//
//  Created by Anna on 21.03.2024.
//

import Foundation
import SwiftUI

struct WeatherData {
    let city: String
    let country: String
    let temperature: Int
    let humidity: Int
    let cloudness: Int
    let windSpeed: Double
    let precipitation: Double
    let dailyChanceOfRain: Int
    let condition: WeatherCondition
    
    enum WeatherCondition: String {
        case sunny = "Sunny"
        case partlyCloudy = "Partly Cloudy"
        case cloudy = "Cloudy"
        
        var image: Image {
            switch self {
            case .sunny: return Image("sun")
            case .partlyCloudy: return Image("sun")
            case .cloudy: return Image("sun")
            }
        }
    }
}

extension WeatherData {
    init(weather: Weather) {
        self = .init(city: weather.location.name,
                     country: weather.location.country,
                     temperature: weather.current.tempC,
                     humidity: weather.current.humidity,
                     cloudness: weather.current.cloud,
                     windSpeed: weather.current.windMPH,
                     precipitation: weather.current.precipMM,
                     dailyChanceOfRain: weather.forecast.forecastday[0].day.dailyChanceOfRain,
                     condition: .init(rawValue: weather.current.condition.text) ?? .sunny)
    }
}
