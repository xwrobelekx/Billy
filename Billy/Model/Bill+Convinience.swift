//
//  Bill+Convinience.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/26/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CoreData

extension Bill {
    
    //i thinik i need to add month property to Bill class which would hold a string value of a month based on the date that was entered
    
    convenience init(title: String, payementAmount: Double, paymentFrequency: String, isPaid: Bool = false, dueDate: Date, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.title = title
        self.payementAmount = payementAmount
        self.payementFrequency = paymentFrequency
        self.isPaid = isPaid
        self.dueDate = dueDate
    }
    
    
    
    
    
    
}
