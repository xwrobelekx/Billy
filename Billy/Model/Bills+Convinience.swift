//
//  Bills+Convinience.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/26/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CoreData


extension Bills {
    convenience init(bills: Bill, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        
    }
    
}

