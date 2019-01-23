//
//  NotificationController.swift
//  Billy
//
//  Created by Kamil Wrobel on 1/8/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation
import UserNotifications


/*
 
 Notification controller handles scheduling notifications - its pre set to 5 days before due date at 8:30 am.
 
 */

class NotificationController {
    
    static let shared = NotificationController()
    private init() {}
    
    
    func setupCustomNotificationWith(title: String, message: String, billDueDate: Date, daysDelay: Int?, atHour: Int?, atMinute: Int?){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("✅ Notifications enabled")
            } else {
                print("📵 Notifications denied")
                #warning("notify user to enable notifications in settings")
                return
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
        
        // days delay / or how many days before due day to fire notification - pre set to 5
        dateComponents.day! -= daysDelay ?? 5
        
        //time
        dateComponents.hour = atHour ?? 8
        dateComponents.minute = atMinute ?? 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let requestId = UUID().uuidString
        let request = UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                
            } else {
                print("Notification with title: \(title) added.")
                print("❗️MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
                
                print("‼️ Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                
            }
        }
    }
}
