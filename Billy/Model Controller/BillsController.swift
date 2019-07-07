//
//  BillsController.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/26/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications


class BillsController {
    
    
    static let shared = BillsController()
    private init() {}
    
    //MARK: - Source of Truth
    var bills = [NewBill]()
    
    
    //MARK: - Create
    func create(bill: NewBill, frequency: BillFrequency?){
        
        // first im adding the initial bill, then checking if there ifs more to add by switching over the frequency
        NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(bill.dueDate.asString()).", billDueDate: bill.dueDate, customIdentyfier: bill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
        
        bills.append(bill)
        
        
        print("🍀 when creating the bill this is the notificvation hour: \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol()), day delay \(SettingController.shared.setting.dayDelay)")
        
        guard let frequency = frequency else {return}
        let dueDate = bill.dueDate
        let calendar = Calendar.current
        switch frequency {
        case .anual:
            print("anual")
            //bill will be aded one time at the begining of the method
            
        case .semiAnual:
            guard let newDueDate = calendar.date(byAdding: DateComponents(month: 6), to: dueDate, wrappingComponents: false) else {return}
            let customIdentyfier = UUID().uuidString
            
            let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
            bills.append(newBill)
            
            NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
            
        case .quarterly:
            var monthsAmountToAdd = 3
            for _ in 0..<3{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                monthsAmountToAdd += 3
            }
            
        case .monthly:
            var monthsAmountToAdd = 1
            for _ in 0..<11{
                print(monthsAmountToAdd)
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                monthsAmountToAdd += 1
            }
        case .biweekly:
            var daysToAdd = 14
            for _ in 0..<26{
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                daysToAdd += 14
            }
        case .weekly:
            var daysToAdd = 7
            for _ in 0..<52{
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                daysToAdd += 7
            }
        case .none:
            print("none")
            //bill will be added one time at the beginign of this method
        }
        
    }
    
    
    //MARK: - Delete
    func delete(bill: NewBill){
        guard let index = bills.index(of: bill) else {
            print("❌no index found of bill to delete")
            return
        }
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [bill.notificationIdentyfier])
        center.removeDeliveredNotifications(withIdentifiers: [bill.notificationIdentyfier])
        bills.remove(at: index)
        print("⛔️sucesfully deleted bill and its notifications: bill title: \(bill.title), bill due date \(bill.dueDate.asStringLonger()), bill payment amount\(bill.paymentAmount)")
    }
    

    
    //MARK: - Filter methods
    func filterBills(by billState : BillState) -> [NewBill]{
        let curnetDate = Date()
        var currentBills = [NewBill]()
        
        switch billState {
        case .isPaid:
            currentBills = bills.filter{ $0.isPaid }
        case .isPastDue:
            currentBills = bills.filter { $0.dueDate < curnetDate && $0.isPaid == false}
        case .isDueNextWeek:
            // 86400 - is one day in seconds - im adding 7 to current date to filter out bills for that week
            currentBills = bills.filter { $0.dueDate >= curnetDate && $0.dueDate <= (curnetDate + (TimeInterval(7 * 86400)))  && $0.isPaid == false }
            for bill in currentBills {
                print("\(bill.title)")
            }
        case .isDueInTwoWeeks:
            currentBills = bills.filter { $0.dueDate >= (curnetDate + (TimeInterval( 7 * 86400))) && $0.dueDate <= curnetDate + (TimeInterval(14 * 86400)) && $0.isPaid == false  }
        case .isDueThisMonth:
             currentBills = bills.filter { $0.dueDate >= (curnetDate ) && $0.dueDate <= curnetDate + (TimeInterval(31 * 86400)) && $0.isPaid == false  }
        case .otherBills:
            currentBills = bills.filter { $0.dueDate > (curnetDate + (TimeInterval( 31 * 86400))) }
        }
        return currentBills
    }
    
    
    
    func filterBills(by month: String ) -> [NewBill]{
        switch month {
        case "January":
            return bills.filter { $0.dueDate.monthAsString() == "01" }
        case "February":
            return bills.filter { $0.dueDate.monthAsString() == "02" }
        case "March":
            return bills.filter { $0.dueDate.monthAsString() == "03" }
        case "April":
            return bills.filter { $0.dueDate.monthAsString() == "04" }
        case "May":
            return bills.filter { $0.dueDate.monthAsString() == "05" }
        case "June":
            return bills.filter { $0.dueDate.monthAsString() == "06" }
        case "July":
            return bills.filter { $0.dueDate.monthAsString() == "07" }
        case "August":
            return bills.filter { $0.dueDate.monthAsString() == "08" }
        case "September":
            return bills.filter { $0.dueDate.monthAsString() == "09" }
        case "October":
            return bills.filter { $0.dueDate.monthAsString() == "10" }
        case "November":
            return bills.filter { $0.dueDate.monthAsString() == "11" }
        case "December":
            return bills.filter { $0.dueDate.monthAsString() == "12" }
        default :
            return [NewBill]()
        }
    }
    
    
    
    //MARK: - Save method
    func saveBills(){
        let jasonEncoder = PropertyListEncoder()
        do {
            let data = try jasonEncoder.encode(self.bills)
            try data.write(to: fileURL())
        }catch let error {
            print("Error encoding data: \(error)")
        }
    }
    
    
    func loadBills(){
        let jasonDecoder = PropertyListDecoder()
        
        do{
            let data = try Data(contentsOf: fileURL())
            let loadedBills = try jasonDecoder.decode([NewBill].self, from: data)
            bills = loadedBills
        } catch let error {
            print("Error decoding data: \(error)")
        }
    }
    
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "billy JSON"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
        
    }

}

