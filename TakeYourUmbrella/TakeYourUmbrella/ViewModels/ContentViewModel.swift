//
//  ContentViewModel.swift
//  TakeYourUmbrella
//
//  Created by Anna on 21.03.2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var weather: Weather?
    private let weatherService = WeatherService()
    
    
    init() {
        //$weatherService
    }
    
    @MainActor func onAppear()  {
        Task {
            let weather = try? await weatherService.fetch(for: "Moscow")
            self.weather = weather
        }
    }
}
