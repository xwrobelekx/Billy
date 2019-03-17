//
//  DateFormater.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/29/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation

/* Notes
 
 - create mechanis to re-ad the bill after the year
 - be able to view full bill - even from month view - and able to update it - maybe even to change the notification
 - app icon
 - push to test flight
 
 
 
 
 */


extension Date {
    
    func asString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func asStringLonger() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func dayAndMonthAsString() -> String {
        let customFormat = "ddMM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func monthAsString() -> String {
        let customFormat = "MM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func monthAsInt() -> Int {
        let customFormat = "MM"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        #warning("Another bang")
        return Int(formatter.string(from: self))!
    }
}


