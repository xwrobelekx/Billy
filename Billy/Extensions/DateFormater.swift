//
//  DateFormater.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/29/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


extension Date {
    
    func asString() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
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
}
