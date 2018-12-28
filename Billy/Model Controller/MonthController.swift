//
//  MonthController.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/4/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


class MonthController {
    
    static let shared = MonthController()
    private init() {}
    
    
    
    let months : [Month] = {
        
        let january = Month(name: Year.january, bills: Bills())
        let february = Month(name: Year.february, bills: Bills())
        let march = Month(name: Year.march, bills: Bills())
        let april = Month(name: Year.april, bills: Bills())
        let may = Month(name: Year.may, bills: Bills())
        let june = Month(name: Year.june, bills: Bills())
        let july = Month(name: Year.july, bills: Bills())
        let august = Month(name: Year.august, bills: Bills())
        let september = Month(name: Year.september, bills: Bills())
        let october = Month(name: Year.october, bills: Bills())
        let november = Month(name: Year.november, bills: Bills())
        let december = Month(name: Year.december, bills: Bills())
        
        return [january, february, march, may, june, july, august, september, october, november, december]
        
    }()
    
    //need to initalize 12 months with names, and empty array if bills
    
    //[.january, .february, .march, .april, .may, .june, .july, .august, .september, .october, .november, .december]
    
    //each month needs to hold array of bills
    
    

    
}
