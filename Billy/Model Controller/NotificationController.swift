//
//  NotificationController.swift
//  Billy
//
//  Created by Kamil Wrobel on 1/8/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications


/*
 
 Notification controller handles scheduling notifications - its pre set to 5 days before due date at 8:30 am.
 
 */

class NotificationController {
    
    static let shared = NotificationController()
    private init() {}
    
    
    ///will hold the identyfiers so the notification can be easly deleted.
    var nonitifcationIdentyfiers: [String] = []
    var permissionGranted = false
    
    
    //MARK: - Notification Permision check
    func checkNotificationPermision() -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (granted, error) in
            if granted {
                print("✅ Notification access Granted")
                self.permissionGranted = true
                SettingController.shared.initialLaunch = false
            } else {
                print("❌ Notification access Denied")
                self.permissionGranted = false
                
            }
            if let error = error {
                print("❌ Error during notification request authorization \(error.localizedDescription)")
            }
        }
        print("❔ Permision status: \(permissionGranted)")
        return permissionGranted
    }
    
    
    func setupNotificationWith(bill: NewBill){
        var title = ""
        var message = ""
        
        let center = UNUserNotificationCenter.current()
        
        if checkNotificationPermision() == false {
            //notifications disabled
            //what if they enable it at later time - bill will be added without the notification
            return
        }
        
        let content = UNMutableNotificationContent()
        
        SettingController.shared.checkNotificationStates()
        
        for notification in SettingController.shared.notificationState {
            
            switch notification {
            case .custom:
                print("1️⃣ Creating custom notification")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= SettingController.shared.setting.dayDelay
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute = SettingController.shared.setting.notificationTime?.hour().min ?? 30
                if SettingController.shared.setting.dayDelay == 1 {
                    title =  "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) day."
                } else {
                    title =  "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days."
                }
                
                content.badge = 1
                content.title = title
                content.body = message
                content.sound = .default
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: bill.notificationIdentyfier[0], content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💜 Notification with title: \(title) added.")
                        print("💜 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        
                        print("💜 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
                print("1️⃣ Finished custom notification 🔐")
                
                
            case .onADueDate:
                print("2️⃣ Creating notification on due date")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= 0
                
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute =  SettingController.shared.setting.notificationTime?.hour().min ?? 30
                title =  "\(bill.title) is due today!"
                
                content.badge = 1
                content.title = title
                content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
                content.sound = .default
                
                let customIdentyfier : String = bill.notificationIdentyfier[1]
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💛 Notification with title: \(title) added.")
                        print("💛 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        
                        print("💛 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
                print("2️⃣ Finished onDueDate notification 🔐")
            case .twoDaysBefore:
                print("3️⃣ Creating notification two daye before")
                
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= 2
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute = SettingController.shared.setting.notificationTime?.hour().min ?? 30
                title =  "\(bill.title) is due in 2 days"
                
                content.badge = 1
                content.title = title
                content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
                content.sound = .default
                
                
                let customIdentyfier : String = bill.notificationIdentyfier[2]
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                        
                    } else {
                        print("💙 Notification with title: \(title) added.")
                        print("💙 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        
                        print("💙 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                        
                    }
                }
                print("3️⃣ Finished TWODayeBefore notification 🔐")
            }
        }
    }
    
    
    
    
    
    
    //    //MARK: - Create notification
    //    func setupCustomNotificationWith(title: String, message: String, billDueDate: Date, customIdentyfiers: [String], daysDelay: Int?, timeDelay: Date?){
    //        let center = UNUserNotificationCenter.current()
    //
    //        if checkNotificationPermision() == false {
    //            //notifications disabled
    //            //what if they enable it at later time - bill will be added without the notification
    //            return
    //        }
    //
    //        let content = UNMutableNotificationContent()
    //        content.title = title
    //
    //
    //        SettingController.shared.checkNotificationStates()
    //
    //
    //        for notification in SettingController.shared.notificationState {
    //
    //            switch notification {
    //            case .custom:
    //                print("1️⃣ Creating custom notification")
    //                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
    //                dateComponents.day! -= daysDelay ?? 5
    //                dateComponents.hour = timeDelay?.hour().hour ?? 8
    //                dateComponents.minute = timeDelay?.hour().min ?? 30
    //                if SettingController.shared.setting.dayDelay == 1 {
    //                    content.title +=  " is due in \(SettingController.shared.setting.dayDelay) day."
    //
    //                } else {
    //                    content.title +=  " is due in \(SettingController.shared.setting.dayDelay) days."
    //                }
    //
    //                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    //
    //                let request = UNNotificationRequest(identifier: customIdentyfiers[0], content: content, trigger: trigger)
    //
    //                center.add(request) { (error) in
    //                    if let error = error {
    //                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
    //
    //                    } else {
    //                        print("💜 Notification with title: \(title) added.")
    //                        print("💜 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
    //
    //                        print("💜 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
    //
    //                    }
    //                }
    //
    //            case .onADueDate:
    //                print("2️⃣ Creating notification on due date")
    //                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
    //                dateComponents.day! -= 0
    //
    //                dateComponents.hour = timeDelay?.hour().hour ?? 8
    //                dateComponents.minute = timeDelay?.hour().min ?? 30
    //                content.title +=  " is due today."
    //
    //
    //                let customIdentyfier : String = {
    //                    if customIdentyfiers.count == 2 {
    //                        return customIdentyfiers[1]
    //                    } else {
    //                        return customIdentyfiers[0]
    //                    }
    //                }()
    //
    //
    //                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    //
    //                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
    //
    //                center.add(request) { (error) in
    //                    if let error = error {
    //                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
    //
    //                    } else {
    //                        print("💛 Notification with title: \(title) added.")
    //                        print("💛 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
    //
    //                        print("💛 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
    //
    //                    }
    //                }
    //
    //            case .twoDaysBefore:
    //                print("3️⃣ Creating notification two daye before")
    //
    //                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: billDueDate)
    //                dateComponents.day! -= 2
    //                dateComponents.hour = timeDelay?.hour().hour ?? 8
    //                dateComponents.minute = timeDelay?.hour().min ?? 30
    //                content.title +=  " is due in 2 days."
    //
    //
    //
    //                let customIdentyfier : String = {
    //                    if customIdentyfiers.count == 3 {
    //                        return customIdentyfiers[2]
    //                    } else if customIdentyfiers.count == 2 {
    //                        return customIdentyfiers[1]
    //                    } else {
    //                        return customIdentyfiers[0]
    //                    }
    //                }()
    //
    //
    //                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    //
    //                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
    //
    //                center.add(request) { (error) in
    //                    if let error = error {
    //                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
    //
    //                    } else {
    //                        print("💙 Notification with title: \(title) added.")
    //                        print("💙 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(billDueDate.debugDescription)")
    //
    //                        print("💙 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
    //
    //                    }
    //                }
    //            }
    //        }
    //    }
}
