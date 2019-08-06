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
//    func create(bill: NewBill, frequency: BillFrequency?){
//        
//        
//        
//        
//        
//        // first im adding the initial bill, then checking if there is more to add by switching over the frequency
//        NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(bill.dueDate.asString()).", billDueDate: bill.dueDate, customIdentyfier: bill.notificationIdentyfier[0], daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//        
//        bills.append(bill)
//        
//        
//        print("🍀 when creating the bill this is the notificvation hour: \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol()), day delay \(SettingController.shared.setting.dayDelay)")
//        
//        guard let frequency = frequency else {return}
//        let dueDate = bill.dueDate
//        let calendar = Calendar.current
//        switch frequency {
//        case .anual:
//            print("anual")
//            //bill will be aded one time at the begining of the method
//            
//        case .semiAnual:
//            guard let newDueDate = calendar.date(byAdding: DateComponents(month: 6), to: dueDate, wrappingComponents: false) else {return}
//            let customIdentyfier = UUID().uuidString
//            
//            let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
//            bills.append(newBill)
//            
//            NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//            
//        case .quarterly:
//            var monthsAmountToAdd = 3
//            for _ in 0..<3{
//                print(monthsAmountToAdd)
//                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
//                let customIdentyfier = UUID().uuidString
//                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
//                bills.append(newBill)
//                
//                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//                
//                monthsAmountToAdd += 3
//            }
//            
//        case .monthly:
//            var monthsAmountToAdd = 1
//            for _ in 0..<11{
//                print(monthsAmountToAdd)
//                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
//                let customIdentyfier = UUID().uuidString
//                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
//                bills.append(newBill)
//                
//                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//                
//                monthsAmountToAdd += 1
//            }
//        case .biweekly:
//            var daysToAdd = 14
//            for _ in 0..<26{
//                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
//                let customIdentyfier = UUID().uuidString
//                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
//                bills.append(newBill)
//                
//                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//                
//                daysToAdd += 14
//            }
//        case .weekly:
//            var daysToAdd = 7
//            for _ in 0..<52{
//                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
//                let customIdentyfier = UUID().uuidString
//                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, notes: bill.notes)
//                bills.append(newBill)
//                
//                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
//                
//                daysToAdd += 7
//            }
//        case .none:
//            print("none")
//            //bill will be added one time at the beginign of this method
//        }
//        
//    }
    
    
    //MARK: - Create Bill 2
    func createBill2(bill: NewBill, frequency: BillFrequency?, howLongToContinue: Int){
        
        
        let todaysYear = Date().yearAsInt()
        let endYear = todaysYear + howLongToContinue
        var dateForWhileStatement = Date()
        print("🧤 start: \(todaysYear) end: \(endYear)")
        
        
        
        for _ in 0...SettingController.shared.notificationState.count{
            bill.notificationIdentyfier.append(UUID().uuidString)
        }
        
        // first im adding the initial bill, then checking if there is more to add by switching over the frequency
        NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(bill.dueDate.asString()).", billDueDate: bill.dueDate, customIdentyfiers: bill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
        
        bills.append(bill)
        bill.notificationIdentyfier.removeAll()
        print("🍀 when creating the bill this is the notificvation hour: \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol()), day delay \(SettingController.shared.setting.dayDelay)")
        
        guard let frequency = frequency else {return}
        let dueDate = bill.dueDate
        let calendar = Calendar.current
        switch frequency {
        case .anual:
            print("anual")
            //bill will be aded one time at the begining of the method
            var monthsAmountToAdd = 12
            while dateForWhileStatement.yearAsInt() < endYear {
            guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
//                let customIdentyfier = UUID().uuidString
                
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: bill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                monthsAmountToAdd += 12
                bill.notificationIdentyfier.removeAll()
            }
            
        case .semiAnual:
            var monthsAmountToAdd = 6
            while dateForWhileStatement.yearAsInt() < endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
//            let customIdentyfier = UUID().uuidString
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
            
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                
            bills.append(newBill)
            
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: newBill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                monthsAmountToAdd += 6
                bill.notificationIdentyfier.removeAll()
            }
            
        case .quarterly:
            var monthsAmountToAdd = 3
            
            while dateForWhileStatement.yearAsInt() < endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
                
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: newBill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                monthsAmountToAdd += 3
                bill.notificationIdentyfier.removeAll()
            }
            
        case .monthly:
            var monthsAmountToAdd = 1
            
            while dateForWhileStatement.yearAsInt() < endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
//                let customIdentyfier = UUID().uuidString
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: newBill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                monthsAmountToAdd += 1
                bill.notificationIdentyfier.removeAll()
            }
        case .biweekly:
            var daysToAdd = 14
            
            while dateForWhileStatement.yearAsInt() < endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
//                let customIdentyfier = UUID().uuidString
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: newBill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                daysToAdd += 14
                bill.notificationIdentyfier.removeAll()
            }
        case .weekly:
            var daysToAdd = 7
            
            while dateForWhileStatement.yearAsInt() < endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
                 dateForWhileStatement = newDueDate
//                let customIdentyfier = UUID().uuidString
                for _ in 0...SettingController.shared.notificationState.count{
                    bill.notificationIdentyfier.append(UUID().uuidString)
                }
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: bill.notificationIdentyfier, notes: bill.notes)
                bills.append(newBill)
                
                NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfiers: newBill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, timeDelay: SettingController.shared.setting.notificationTime)
                
                daysToAdd += 7
                bill.notificationIdentyfier.removeAll()
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
        center.removePendingNotificationRequests(withIdentifiers: bill.notificationIdentyfier)
        center.removeDeliveredNotifications(withIdentifiers: bill.notificationIdentyfier)
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
    
    
    
    func filterBills(by month: String, year: Int ) -> [NewBill]{
        switch month {
        case "January":
            return bills.filter { $0.dueDate.monthAsString() == "01" && $0.dueDate.yearAsInt() == year }
        case "February":
            return bills.filter { $0.dueDate.monthAsString() == "02" && $0.dueDate.yearAsInt() == year }
        case "March":
            return bills.filter { $0.dueDate.monthAsString() == "03" && $0.dueDate.yearAsInt() == year }
        case "April":
            return bills.filter { $0.dueDate.monthAsString() == "04" && $0.dueDate.yearAsInt() == year }
        case "May":
            return bills.filter { $0.dueDate.monthAsString() == "05" && $0.dueDate.yearAsInt() == year }
        case "June":
            return bills.filter { $0.dueDate.monthAsString() == "06" && $0.dueDate.yearAsInt() == year }
        case "July":
            return bills.filter { $0.dueDate.monthAsString() == "07" && $0.dueDate.yearAsInt() == year }
        case "August":
            return bills.filter { $0.dueDate.monthAsString() == "08" && $0.dueDate.yearAsInt() == year }
        case "September":
            return bills.filter { $0.dueDate.monthAsString() == "09" && $0.dueDate.yearAsInt() == year }
        case "October":
            return bills.filter { $0.dueDate.monthAsString() == "10" && $0.dueDate.yearAsInt() == year }
        case "November":
            return bills.filter { $0.dueDate.monthAsString() == "11" && $0.dueDate.yearAsInt() == year }
        case "December":
            return bills.filter { $0.dueDate.monthAsString() == "12" && $0.dueDate.yearAsInt() == year }
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

