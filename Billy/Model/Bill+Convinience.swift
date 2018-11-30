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
    
    convenience init(title: String, payementAmount: Double, isPaid: Bool = false, dueDate: Date, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.title = title
        self.payementAmount = payementAmount
        self.isPaid = isPaid
        self.dueDate = dueDate
    }
    
    
    
    
}
