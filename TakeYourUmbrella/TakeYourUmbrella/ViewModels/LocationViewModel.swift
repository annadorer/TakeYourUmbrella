//
//  LocationViewModel.swift
//  TakeYourUmbrella
//
//  Created by Anna on 09.04.2024.
//

import Foundation

class LocationViewModel: ObservableObject {
    
    @Published var location: [LocationData] = []
    @Published var dataIsEmpty: Bool = false
    private let locationService = LocationService()
    
    @MainActor func loadData(city: String) {
        Task {
            let location = try? await locationService.searchLocation(for: city)
            if location != nil {
                self.location = location!
                self.dataIsEmpty = false
            } else {
                self.dataIsEmpty = true
            }
        }
    }
}
