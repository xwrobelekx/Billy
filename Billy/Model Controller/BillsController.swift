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
    
    var bills: [Bill] {
        
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
        
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
            print("Error saving to persisten store. \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: - Trying to separate bills into weakly segments here
    
    //paid tab for current month?
    
    //past due
    
    //due this week
    
    //due next week
    
    //due 2 weeks from now
    
    //due more than two weeks from now - but dont show more than a  month of bills - maybe include a quarterly bills
    
    /*
  need curent date - then use filter to filter my array, and use if statments or case statement to put then in apropriate sections - try doing it in a fuction so is reusable for ading/deleting
 
 */
    //filter bills array and return an array fo bills with apropriate cryteria
    
    enum BillState{
        case isPaid
        case isPastDue
        case isDueNextWeek
        case isDueInTwoWeeks
        case isDueThisMonth
    }
    
    func filterBills(by billState : BillState) -> [Bill]{
        
        let curnetDate = Date()
        
        //check if the bill was paid if it was and its before or after the date of a current month, then move it to paid tab
        
        //if the bill
        
        let currentBills = [Bill]()
        
        switch billState {
        case .isPaid:
            print("isPaid")
        case .isPastDue:
            print("isPastDue")
        case .isDueNextWeek:
            print("isDueNextWeek")
        case .isDueInTwoWeeks:
            print("isDueInTwoWeeks")
        case .isDueThisMonth:
            print("isDueThisMonth")
        }
        
        return currentBills
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
