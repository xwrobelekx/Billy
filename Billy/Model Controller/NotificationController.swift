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
    
    
    ///will hold the identyfiers so the notification can be easly deleted.
    var conitifcationIdentyfiers: [String] = []
    
    
    
    
    func setupCustomNotificationWith(title: String, message: String, billDueDate: Date, customIdentyfier: String, daysDelay: Int?, timeDelay: Date?){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
            } else {
                return
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
        dateComponents.day! -= daysDelay ?? 5
        dateComponents.hour = timeDelay?.hour().hour ?? 8
        dateComponents.minute = timeDelay?.hour().min ?? 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                
            } else {
                print("✅Notification with title: \(title) added.")
                print("✅MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
                
                print("✅ Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                
            }
        }
    }
}
