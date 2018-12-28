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
    let moc = CoreDataStack.context
    
    var bills: [Bill] {
        
        let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
        
        return (try?  moc.fetch(fetchRequest)) ?? []

    }
    
    
    func create(bill: Bill, frequency: BillFrequency){
    
       // how is a bill being created and saved - its not getting added to the array - its being fetched from core data,
        
        
        //when creating a bill need to assign a month to it, and frequency, if frequency is monthly, then i need to c reate 12 of them for that year
        
        //86400 is number of seconds in one day
        let week = (TimeInterval(7 * 86400))
        let month = (TimeInterval(30 * 86400))
        let oneQuarter = (TimeInterval(91.25 * 86400))
        
        
        switch frequency {
         case .anual:
            //dont need to do anyting
            print("Created anual bill")
         case .semiAnual:
            
            var firstBillDate = bill.dueDate! + week //6 months
           // let bill = Bill(title: <#T##String#>, payementAmount: <#T##Double#>, paymentFrequency: <#T##String#>, dueDate: <#T##Date#>)
            
            print("created 2 bills for semianual payments")
        case .quarterly:
            
            print("created 4 bills for quarterly payments")

        case .monthly:
            
            print("created 12 bills for monthly payments")

        case .biweekly:
            
            print("created 26 bills for biweekly payments")

        case .weekly:
            
            print("created 52 bills for weekly payments")

            
        }
        
        
        
        
        
        saveToPersistentStore()
    }
    
    func delete(bill: Bill){
        moc.delete(bill)
        saveToPersistentStore()
    }
    
    
    func saveToPersistentStore() {
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
        var currentBills = [Bill]()
        
        switch billState {
        case .isPaid:
            currentBills = bills.filter{ $0.isPaid }
        case .isPastDue:
            currentBills = bills.filter { $0.dueDate! < curnetDate && $0.isPaid == false}
        case .isDueNextWeek:
            // 86400 - is one day in seconds - im adding 7 to current date to filter out bills for that week
            currentBills = bills.filter { $0.dueDate! >= curnetDate && $0.dueDate! <= curnetDate + (TimeInterval(7 * 86400))  && $0.isPaid == false }
        case .isDueInTwoWeeks:
            currentBills = bills.filter { $0.dueDate! >= (curnetDate + (TimeInterval( 7 * 86400))) && $0.dueDate! <= curnetDate + (TimeInterval(14 * 86400)) && $0.isPaid == false  }
        case .isDueThisMonth:
            currentBills = bills.filter { $0.dueDate! >= (curnetDate + (TimeInterval( 14 * 86400))) && $0.dueDate! <= curnetDate + (TimeInterval(31 * 86400)) && $0.isPaid == false  }
        }
        return currentBills
    }
    
    
//    func something() {
//        let startDate = Date()
//        let endDate = Date(timeInterval: 2*86400, since: startDate)
//        
//        
//        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
//        let numberOfDays = components.day ?? 0
//        
//        for i in 1...numberOfDays {
//            let nextDate = Calendar.current.date(byAdding: .day, value: i, to: startDate)
//            print(nextDate)
//        }
//    }
    
    
    
    
    
    
    
}
