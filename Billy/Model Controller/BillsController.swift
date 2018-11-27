//
//  BillsController.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/26/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation
import CoreData


class BillsController {
    
    static let shared = BillsController()
    private init() {}
    
    var bills: [Bills] {
        
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Bills> = Bills.fetchRequest()
        
        return (try?  moc.fetch(fetchRequest)) ?? []

    }
    
    
    func create(bill: Bill){
        saveToPersistentStore()
    }
    
    func delete(bill: Bill){
        let moc = CoreDataStack.context
        moc.delete(bill)
        saveToPersistentStore()
    }
    
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("Error savint to persisten store. \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
    
    
}
