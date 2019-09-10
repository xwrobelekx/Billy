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
    
    //MARK: - Temporary paid bills storage
    var paidBills = Set<NewBill>()
    
<<<<<<< HEAD
    //MARK: - Create
    func create(bill: NewBill){
        
        // first im adding the initial bill, then checking if there ifs more to add by switching over the frequency
        NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(bill.dueDate.asString()).", billDueDate: bill.dueDate, customIdentyfier: bill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, atHour: SettingController.shared.setting.hour, atMinute: SettingController.shared.setting.minute)
=======
    
    //MARK: - Create Bill 2
    func createBill2(bill: NewBill, frequency: BillFrequency?, howLongToContinue: Int){
>>>>>>> develop
        
//        let todaysYear = Date().yearAsInt()
        let endYear = howLongToContinue
        var dateForWhileStatement = Date()
//        print("🧤 start: \(todaysYear) end: \(endYear)")
        bill.notificationIdentyfier = generateThreeIdentyfiers()
        
        // first im adding the initial bill, then checking if there is more to add by switching over the frequency
        NotificationController.shared.setupNotificationWith(bill: bill)
        
        bills.append(bill)
        //        print("🍀 when creating the bill this is the notificvation hour: \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol()), day delay \(SettingController.shared.setting.dayDelay)")
        
        let frequency = bill.billFrequency
        let dueDate = bill.dueDate
        let calendar = Calendar.current
        switch frequency {
        case .anual:
            print("anual")
            //bill will be aded one time at the begining of the method
            var monthsAmountToAdd = 12
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers() , notes: bill.notes)
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
                monthsAmountToAdd += 12
            }
            
        case .semiAnual:
<<<<<<< HEAD
            guard let newDueDate = calendar.date(byAdding: DateComponents(month: 6), to: dueDate, wrappingComponents: false) else {return}
            let customIdentyfier = UUID().uuidString
            
            let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier, billUniqueIdentyfier: bill.billUniqueIdentyfier, billFrequency: bill.billFrequency, notes: bill.notes)
            bills.append(newBill)
            
            NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(newDueDate.asString()).", billDueDate: newDueDate, customIdentyfier: customIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, atHour: SettingController.shared.setting.hour, atMinute: SettingController.shared.setting.minute)
=======
            var monthsAmountToAdd = 6
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers(), notes: bill.notes)
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
                monthsAmountToAdd += 6
            }
>>>>>>> develop
            
        case .quarterly:
            var monthsAmountToAdd = 3
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
<<<<<<< HEAD
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier,  billUniqueIdentyfier: bill.billUniqueIdentyfier, billFrequency: bill.billFrequency, notes: bill.notes)
=======
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers(), notes: bill.notes)
>>>>>>> develop
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
                monthsAmountToAdd += 3
            }
            
        case .monthly:
            var monthsAmountToAdd = 1
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(month: monthsAmountToAdd), to: dueDate, wrappingComponents: false) else {return}
<<<<<<< HEAD
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier,  billUniqueIdentyfier: bill.billUniqueIdentyfier, billFrequency: bill.billFrequency, notes: bill.notes)
=======
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers(), notes: bill.notes)
>>>>>>> develop
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
                monthsAmountToAdd += 1
            }
        case .biweekly:
            var daysToAdd = 14
            
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
<<<<<<< HEAD
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier,  billUniqueIdentyfier: bill.billUniqueIdentyfier, billFrequency: bill.billFrequency, notes: bill.notes)
=======
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers(), notes: bill.notes)
>>>>>>> develop
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
                daysToAdd += 14
            }
        case .weekly:
            var daysToAdd = 7
            while dateForWhileStatement.yearAsInt() <= endYear {
                guard let newDueDate = calendar.date(byAdding: DateComponents(day: daysToAdd), to: dueDate, wrappingComponents: false) else {return}
<<<<<<< HEAD
                let customIdentyfier = UUID().uuidString
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: customIdentyfier,  billUniqueIdentyfier: bill.billUniqueIdentyfier, billFrequency: bill.billFrequency, notes: bill.notes)
=======
                dateForWhileStatement = newDueDate
                let newBill = NewBill(title: bill.title, dueDate: newDueDate, paymentAmount: bill.paymentAmount, isPaid: bill.isPaid, notificationIdentyfier: generateThreeIdentyfiers(), notes: bill.notes)
>>>>>>> develop
                bills.append(newBill)
                NotificationController.shared.setupNotificationWith(bill: newBill)
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
//         print("📲📲📲\(bill.notificationIdentyfier)")
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (pendingNotifications) in
//            print("💡 Pending notifications count: \(pendingNotifications.count)")
        }
        center.removePendingNotificationRequests(withIdentifiers: bill.notificationIdentyfier)
        center.removeDeliveredNotifications(withIdentifiers: bill.notificationIdentyfier)
        bills.remove(at: index)
//        print("⛔️sucesfully deleted bill and its notifications: bill title: \(bill.title), bill due date \(bill.dueDate.asStringLonger()), bill payment amount\(bill.paymentAmount)")
    }
    
<<<<<<< HEAD
    //MARK: - Update Bill
    func update(bill: NewBill, updateAllBills: Bool){
        
        #warning("unfinished section - will need something like this if i want to update all the bill with the same title.")
        if updateAllBills == true {
            for oldBill in bills {
                if bill.billUniqueIdentyfier == oldBill.billUniqueIdentyfier && !bill.isPaid {
                    oldBill.title = bill.title
                    oldBill.paymentAmount = bill.paymentAmount
                    oldBill.notes = bill.notes
                    //if the date was changed - old bill due date is not equal to new bill due date then user updated the date so we need to update notifications
                    if  oldBill.dueDate != bill.dueDate{
                        print("‼️ due date was changed - no code here")
                        return
                        //need to remove old bills, and create new ones in their place - bc there is no mechanis to recreate notifications
                        NotificationController.shared.removeNotification(for: oldBill.notificationIdentyfier)
                        BillsController.shared.delete(bill: oldBill)
                        #warning("this is not gone work - bc its gone replace old bill due date with new one - but in a way where old due date could be in june, and new one in february")
                        BillsController.shared.create(bill: bill)
                        
                        
                        
                       //remove old notification, add new one with the new date - repeat that same amount of time the bill still exists - or add properrty tot he bill called frequency - this would help when recreating the bill
                        
                    }
                }
            }
        } else {
            print("✅ updating bill")
            for oldBill in bills {
                if bill.billUniqueIdentyfier == oldBill.billUniqueIdentyfier {
                    oldBill.title = bill.title
                    oldBill.dueDate = bill.dueDate
                    oldBill.paymentAmount = bill.paymentAmount
                    oldBill.notes = bill.notes
                    
                    NotificationController.shared.removeNotification(for: oldBill.notificationIdentyfier)
                     print("✅ removed notification for \(oldBill.title)")
                       NotificationController.shared.setupCustomNotificationWith(title: "\(bill.title) is due in \(SettingController.shared.setting.dayDelay) days.", message: "Payment of $\(bill.paymentAmount) is due on \(bill.dueDate.asString()).", billDueDate: bill.dueDate, customIdentyfier: bill.notificationIdentyfier, daysDelay: SettingController.shared.setting.dayDelay, atHour: SettingController.shared.setting.hour, atMinute: SettingController.shared.setting.minute)
                }
            }
            
        }
        
    }
    
    
    //MARK: - Number of same bills
    func returnNumberOfSameBills(as thisBill: NewBill) -> Int {
        var billCount = 0
        for bill in bills {
            if bill.billUniqueIdentyfier == thisBill.billUniqueIdentyfier {
                billCount += 1
            }
            
        }
        return billCount
    }
    

=======
    
>>>>>>> develop
    
    //MARK: - Filter methods
    func filterBills(by billState : BillState) -> [NewBill]{
        let curnetDate = Date()
        var currentBills = [NewBill]()
        
        switch billState {
        case .isPaid:
            currentBills = bills.filter{ $0.isPaid }
        case .recentleyPaid:
               currentBills = bills.filter{ $0.isPaid && $0.dueDate > (curnetDate.addingTimeInterval(-14 * 86400)) }
        case .isPastDue:
            currentBills = bills.filter { $0.dueDate < curnetDate && $0.isPaid == false}
        case .isDueInFiveDays:
            currentBills = bills.filter { $0.dueDate >= curnetDate && $0.dueDate <= (curnetDate + (TimeInterval(5 * 86400)))  && $0.isPaid == false }
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
    
    //MARK: - Track Paid Bills
    //keeps track of paid bills to remove pending notifications
    
    func markBillPaid(bill: NewBill){
       let result = paidBills.insert(bill)
        if result.inserted == false {
            //if the bill wasnt inserted, because there was a duplicate, that means they marked the bill back to unpaid state, there fore we want to remove it from the set. 
            paidBills.remove(bill)
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
    
    //MARK: - Helper Methods
    func generateThreeIdentyfiers() -> [String]{
        var identyfiers : [String] = []
        for _ in 0...2 {
            identyfiers.append(UUID().uuidString)
        }
        return identyfiers
    }
    
}

