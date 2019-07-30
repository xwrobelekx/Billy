//
//  Log.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/29/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


class Log {
    var category: String
    var amount: Double
    var date: Date?
    
    init(category: String, amount: Double, date: Date? = Date()){
        self.category = category
        self.amount = amount
        self.date = date
    }
    
    
}
