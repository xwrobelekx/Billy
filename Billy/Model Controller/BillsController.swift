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
    
    //MARK: - Source of Truth
    var bills: [Bill] {
        let fetchRequest: NSFetchRequest<Bill> = Bill.fetchRequest()
        return (try?  moc.fetch(fetchRequest)) ?? []
    }
    
    
    //MARK: - Create
    func create(bill: Bill, frequency: BillFrequency){
        guard let dueDate = bill.dueDate else {return}
        let calendar = Calendar.current
        switch frequency {
        case .anual:
            print("anual")
        case .semiAnual:
            guard let newDueDate = calendar.date(byAdding: DateComponents(month: 6), to: dueDate, wrappingComponents: false) else {return}
            let _ = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
            saveToPersistentStore()
            
        case .quarterly:
            var monthsAmountToAdd = 3
            for _ in 0..<3{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
               let _ = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
              //  allTheBills.append(newBill)
                saveToPersistentStore()
                monthsAmountToAdd += 3
            }
            
        case .monthly:
            var monthsAmountToAdd = 1
            for _ in 0..<11{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                let _ = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
                saveToPersistentStore()
                monthsAmountToAdd += 1
            }
        case .biweekly:
            var daysToAdd = 14
            for _ in 0..<26{
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                let _ = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
                saveToPersistentStore()
                daysToAdd += 14
            }
        case .weekly:
            var daysToAdd = 7
            for _ in 0..<52{
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
               let _ = Bill(title: bill.title ?? "No Title", payementAmount: bill.payementAmount, dueDate: newDueDate, notes: bill.notes)
                saveToPersistentStore()
                daysToAdd += 7
            }
        case .none:
            print("none")
        }
        saveToPersistentStore()
    }
    
    
    //MARK: - Delete
    func delete(bill: Bill){
        moc.delete(bill)
        saveToPersistentStore()
    }
    
    
    //MARK: - Save
    func saveToPersistentStore() {
        do {
            try moc.save()
        } catch {
            print("Error saving to persisten store. \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: - Filter methods
    func filterBills(by billState : BillState) -> [Bill]{
        let curnetDate = Date()
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
    

    
    func filterBills(by month: Year ) -> [Bill]{
        switch month {
        case .january:
            return bills.filter { $0.dueDate!.monthAsString() == "01" }
        case .february:
             return bills.filter { $0.dueDate!.monthAsString() == "02" }
        case .march:
             return bills.filter { $0.dueDate!.monthAsString() == "03" }
        case .april:
             return bills.filter { $0.dueDate!.monthAsString() == "04" }
        case .may:
             return bills.filter { $0.dueDate!.monthAsString() == "05" }
        case .june:
            return bills.filter { $0.dueDate!.monthAsString() == "06" }
        case .july:
             return bills.filter { $0.dueDate!.monthAsString() == "07" }
        case .august:
             return bills.filter { $0.dueDate!.monthAsString() == "08" }
        case .september:
             return bills.filter { $0.dueDate!.monthAsString() == "09" }
        case .october:
             return bills.filter { $0.dueDate!.monthAsString() == "10" }
        case .november:
             return bills.filter { $0.dueDate!.monthAsString() == "11" }
        case .december:
             return bills.filter { $0.dueDate!.monthAsString() == "12" }
        }
    }
    
    
    
    
    
    
}
