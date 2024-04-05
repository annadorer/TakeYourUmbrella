//
//  NotificationService.swift
//  TakeYourUmbrella
//
//  Created by Anna on 05.04.2024.
//

import Foundation
import UserNotifications

struct Notifications {
    func requestNotificationAuthorization(dailyChanceOfRain: Int) {
        // Запрос на разрешение отправки уведомлений
 
        //    scheduleRainNotification(dailyChanceOfRain: Int)
      //  }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                if granted {
                    print("Permission granted")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    
    func scheduleRainNotification(dailyChanceOfRain: Int) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Take your umbrella!"
        content.body = "Ожидаются осадки. Не забудьте взять зонтик с собой."
        
        // Проверка количества осадков
        let isRaining = dailyChanceOfRain >= 40
        
        if isRaining {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Уведомление через 5 секунд
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error != nil else { return }
            }
        }
    }
}
