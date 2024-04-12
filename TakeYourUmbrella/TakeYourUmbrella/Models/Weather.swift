//
//  Weather.swift
//  TakeYourUmbrella
//
//  Created by Anna on 20.03.2024.
//

import Foundation

struct Weather: Decodable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
    struct Location: Decodable {
        let name: String
        let region: String
        let country: String
        
//        enum CodingKeys: String, CodingKey {
//            case name = "name"
//            case region = "region"
//            case country = "country"
//            //case id
//        }
    }
    
    struct Condition: Decodable {
        let text: String
    }
    
    struct Current: Decodable {
        let tempC: Int
        let windMPH: Double
        let humidity: Int
        let cloud: Int
        let precipMM: Double
        let condition: Condition
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case windMPH = "wind_mph"
            case precipMM = "precip_mm"
            case humidity
            case condition
            case cloud
        }
    }
    
    struct Forecast: Decodable {
        let forecastday: [Forecastday]
    }
    
    struct Forecastday: Decodable {
        let day: Day
    }
    
    struct Day: Decodable {
        let dailyChanceOfRain: Int
        
        enum CodingKeys: String, CodingKey {
            case dailyChanceOfRain = "daily_chance_of_rain"
        }
    }
}
