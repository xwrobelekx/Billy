//
//  Month+Convenience.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/4/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CoreData


extension Month {
    
    convenience init(name: Year, bills: Bills, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name.rawValue
        self.bills = bills
    }
    
    
    
    
}

