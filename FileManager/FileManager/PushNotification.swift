//
//  PushNotification.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import Foundation
import UIKit

class PushNotification {
    var isPushSent: Bool = false
    func sendPushNotification(downloadNumber: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Download Finished"
        content.body = "Your Download \(downloadNumber) is finished "
        content.sound = UNNotificationSound.default
       
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: .none)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}

