//
//  TakeYourUmbrellaApp.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI

@main
struct TakeYourUmbrellaApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
        }
    }
}
