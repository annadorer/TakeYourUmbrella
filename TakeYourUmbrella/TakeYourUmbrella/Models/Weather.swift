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
    
    struct Location: Decodable {
        let name: String
        let country: String
    }
    
    struct Condition: Decodable {
        let text: String
        let icon: String
    }
    
    struct Current: Decodable {
        let tempC: Int
        let windMPH: Double
        let humidity: Int
        let cloud: Int
        let condition: Condition
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case windMPH = "wind_mph"
            case humidity
            case condition
            case cloud
        }
    }
}
