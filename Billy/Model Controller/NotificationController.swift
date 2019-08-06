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
    
    
    
    
    func setupCustomNotificationWith(title: String, message: String, billDueDate: Date, customIdentyfiers: [String], daysDelay: Int?, timeDelay: Date?){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("✅ Notification access Granted")
            } else {
                print("❌ Notification access Denied")
                //present alert
                return
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        
        for notification in SettingController.shared.notificationState {
            
            switch notification {
            case .custom:
                print("1️⃣ Creating custom notification")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
                dateComponents.day! -= daysDelay ?? 5
                dateComponents.hour = timeDelay?.hour().hour ?? 8
                dateComponents.minute = timeDelay?.hour().min ?? 30
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: customIdentyfiers[0], content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💜 Notification with title: \(title) added.")
                        print("💜 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
                        
                        print("💜 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
                
            case .onADueDate:
                print("2️⃣ Creating notification on due date")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
                dateComponents.hour = timeDelay?.hour().hour ?? 8
                dateComponents.minute = timeDelay?.hour().min ?? 30
                
                let customIdentyfier : String = {
                    if customIdentyfiers.count == 2 {
                        return customIdentyfiers[1]
                    } else {
                        return customIdentyfiers[0]
                    }
                }()
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💛 Notification with title: \(title) added.")
                        print("💛 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
                        
                        print("💛 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
                
            case .twoDaysBefore:
                print("3️⃣ Creating notification two daye before")
                
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
                dateComponents.day! -= 2
                dateComponents.hour = timeDelay?.hour().hour ?? 8
                dateComponents.minute = timeDelay?.hour().min ?? 30
                
                
                let customIdentyfier : String = {
                    if customIdentyfiers.count == 3 {
                        return customIdentyfiers[2]
                    } else if customIdentyfiers.count == 2 {
                        return customIdentyfiers[1]
                    } else {
                        return customIdentyfiers[0]
                    }
                }()
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💙 Notification with title: \(title) added.")
                        print("💙 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
                        
                        print("💙 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
            }
        }
    }
}
