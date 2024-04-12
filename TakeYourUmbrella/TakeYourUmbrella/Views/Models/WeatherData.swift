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
    let region: String
    let country: String
    let temperature: Int
    let humidity: Int
    let cloudness: Int
    let windSpeed: Double
    let precipitation: Int
    let dailyChanceOfRain: Int
    let condition: WeatherCondition
    
    enum WeatherCondition: String {
        case sunny = "Sunny"
        case partlyCloudy = "Partly Cloudy"
        case cloudy = "Cloudy"
        case mist = "Mist"
        case patchyRainPossible = "Patchy rain possible"
        case patchySnowPossible = "Patchy snow possible"
        case patchySleetPossible = "Patchy sleet possible"
        case heavyRain = "Heavy rain"
        
        var image: String {
            switch self {
            case .sunny: return "sun"
            case .partlyCloudy: return "partlyCloudy"
            case .cloudy: return "cloudy"
            case .mist: return "mist"
            case .patchyRainPossible: return "patchyRainPossible"
            case .patchySnowPossible: return "patchySnowPossible"
            case .patchySleetPossible: return "patchySleetPossible"
            case .heavyRain : return "heavyRain"
            }
        }
    }
}

extension WeatherData {
    init(weather: Weather) {
        self = .init(city: weather.location.name,
                     region: weather.location.region,
                     country: weather.location.country,
                     temperature: weather.current.tempC,
                     humidity: weather.current.humidity,
                     cloudness: weather.current.cloud,
                     windSpeed: weather.current.windMPH,
                     precipitation: Int(weather.current.precipMM),
                     dailyChanceOfRain: weather.forecast.forecastday[0].day.dailyChanceOfRain,
                     condition: .init(rawValue: weather.current.condition.text) ?? .sunny)
    }
}
