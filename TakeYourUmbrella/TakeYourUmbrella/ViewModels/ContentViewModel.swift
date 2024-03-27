//
//  ContentViewModel.swift
//  TakeYourUmbrella
//
//  Created by Anna on 21.03.2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var weather: WeatherData? = nil
    private let weatherService = WeatherService()
    
    @MainActor func onAppear()  {
        Task {
            let weather = try? await weatherService.fetch(for: "Sydney")
            if weather != nil {
                self.weather = WeatherData(weather: weather!)
            }
        }
    }
}
