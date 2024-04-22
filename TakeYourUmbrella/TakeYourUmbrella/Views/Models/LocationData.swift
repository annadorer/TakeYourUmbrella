//
//  LocationData.swift
//  TakeYourUmbrella
//
//  Created by Anna on 10.04.2024.
//

import Foundation

struct LocationData: Identifiable, Codable {
    var id =  UUID()
    let city: String
    let region: String
    let country: String
}

extension LocationData {
    init(weather: Weather.Location) {
        self = .init(city: weather.name,
                     region: weather.region,
                     country: weather.country)
    }
    
}
