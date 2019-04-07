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
 - start the monthy view on current month
 - add icons to tab bar controller
 - text field - cant see the cursor when adding bills
 - add functionality to the check box on monthly view
 - update view on detail
 - how about when creating a bill i would give it a unique identyfier so that i can find all of them that were created at once - but then they all have the same title, and amount - i just need to update the equatable method to exclude the identyfier for notifications
- fix the notification comparsment on date - for this you may have to switch the time to system time insted of array of numbers
 
 
 
 
 
 
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
    
    func monthAndYearAsString() -> String {
        let customFormat = "MMYY"
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
    
    func timeAsString() -> (String) {
        let customFormat = "HH:mm"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return (formatter.string(from: self))
    }
    
    
    func hour() -> Int {
    let customFormat = "HH"
    let locale = Locale(identifier: "en_US")
    let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return Int(formatter.string(from: self))!
    }
    
    func minute() -> Int {
        let customFormat = "mm"
        let locale = Locale(identifier: "en_US")
        let format = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: locale)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return Int(formatter.string(from: self))!
    }
}


