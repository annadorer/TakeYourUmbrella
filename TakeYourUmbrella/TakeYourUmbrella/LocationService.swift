//
//  LocationService.swift
//  TakeYourUmbrella
//
//  Created by Anna on 27.03.2024.
//

import Foundation

struct LocationService {
    
    private let apiKey: String = "ff725df2c6d146c2ac791418242603"
    
    func searchlocation(for city: String) async throws -> Weather.Location {
        guard let url = URL(string: "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(city)") else { throw NSError() }
        let response = try await URLSession.shared.data(from: url)
        let location = try JSONDecoder().decode(Weather.Location.self, from: response.0)
        return location
    }
}

//actor LocationCashe {
//    
//    let source: LocationService
//    
//    init(source: LocationService) {
//        self.source = source
//    }
//    
//    var cities: [String] {
//        if let cities = cachedCities {
//            return cities
//        }
//
////        let cities = source.searchlocation(for: "")
////        cachedCities = cities
////
////        return cities
//    //}
//
//    private var cachedCities: [String]?
        

    
//}


