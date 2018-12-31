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
        print("fetching bills")
        let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
        
        return (try?  moc.fetch(fetchRequest)) ?? []

    }
    
    
    func create(bill: Bill, frequency: BillFrequency){
    
        guard let dueDate = bill.dueDate else {return}
        let calendar = Calendar.current
        
        switch frequency {
        case .anual:
            print("anual")
        case .semiAnual:
            guard let newDueDate = calendar.date(byAdding: DateComponents(month: 6), to: dueDate, wrappingComponents: false) else {return}
            let newBill = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
          //  allTheBills.append(newBill)
            saveToPersistentStore(bill: newBill)
            
        case .quarterly:
            
            var monthsAmountToAdd = 3
            
            for _ in 0..<3{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
               let newBill = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
              //  allTheBills.append(newBill)
                saveToPersistentStore(bill: newBill)
                monthsAmountToAdd += 3
            }
            
        case .monthly:
            var monthsAmountToAdd = 1
            for _ in 0..<12{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                let newBill = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
             //   allTheBills.append(newBill)
                saveToPersistentStore(bill: newBill)
                monthsAmountToAdd += 1
            }
            
            // add a month to the previous data leaving th day the samy - repeat remaining times for each month still remaining in the year - u
            
            print("monthly")
        case .biweekly:
            var daysToAdd = 14
            for _ in 0..<26{
                print(daysToAdd)
                
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                let newBill = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
               // allTheBills.append(newBill)
                saveToPersistentStore(bill: newBill)
                daysToAdd += 14
            }
            print("biweekly")
        case .weekly:
            var daysToAdd = 7
            for _ in 0..<52{
                print(daysToAdd)
                
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
               let newBill = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
               // allTheBills.append(newBill)
                saveToPersistentStore(bill: newBill)
                daysToAdd += 7
            }
            print("weekly")
        case .none:
            print("none")
        }

        
        
        
        
        
        saveToPersistentStore(bill: bill)
    }
    
    func delete(bill: Bill){
        moc.delete(bill)
        saveToPersistentStore(bill: bill)
    }
    
    #warning("remove the extra bill parameter - only used for testing")
    func saveToPersistentStore(bill: Bill) {
        print("Saving \(bill.title) with date: \(bill.dueDate?.asString())")
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
        case otherBills
        #warning("extra case for testing")
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
        case .otherBills:
            currentBills = bills.filter { $0.dueDate! > (curnetDate + (TimeInterval( 31 * 86400))) }
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
