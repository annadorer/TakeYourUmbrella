//
//  TakeYourUmbrellaApp.swift
//  TakeYourUmbrella
//
//  Created by Anna on 11.03.2024.
//

import SwiftUI
import UserNotifications

@main
struct TakeYourUmbrellaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//private func registerForPushNotifications() {
//    UNUserNotificationCenter.current().delegate = self
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//        (granted, error) in
//        // 1. Check to see if permission is granted
//        guard granted else { return }
//        // 2. Attempt registration for remote notifications on the main thread
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//}
//
//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    registerForPushNotifications()
//    return true
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print(deviceToken)
//    }
//    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print(error)
//    }
//}
