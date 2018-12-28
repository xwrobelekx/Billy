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
        
        let january = Month(name: Year.january)
        let february = Month(name: Year.february)
        let march = Month(name: Year.march)
        let april = Month(name: Year.april)
        let may = Month(name: Year.may)
        let june = Month(name: Year.june)
        let july = Month(name: Year.july)
        let august = Month(name: Year.august)
        let september = Month(name: Year.september)
        let october = Month(name: Year.october)
        let november = Month(name: Year.november)
        let december = Month(name: Year.december)
        
        return [january, february, march, april, may, june, july, august, september, october, november, december]
        
    }()
    
    //need to initalize 12 months with names, and empty array if bills
    
    //[.january, .february, .march, .april, .may, .june, .july, .august, .september, .october, .november, .december]
    
    //each month needs to hold array of bills
    
    

    
}
