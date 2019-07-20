//
//  BillDetailVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/7/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications

class BillDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    //MARK: - Outlets
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var billsTableView: UITableView!
    
    
    
    
    //MARK: - Preoperties
    var bill : NewBill? {
        didSet {
            print("bill updated")
        }
    }
    
    let center = UNUserNotificationCenter.current()
    var someBills = [NewBill]()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        getBills()
        updateViews()
        billsTableView.delegate = self
        billsTableView.dataSource = self
        // Do any additional setup after loading the view.
        

    }
    

 
    //MARK: - Actions
    
    @IBAction func editButtonPressed(_ sender: Any) {
    }
    
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        guard let curentBill = bill else {return}
        BillsController.shared.delete(bill: curentBill)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews() {
        
        guard let currentBill = bill else {return}
        titleLabel.text = currentBill.title
        amoutLabel.text = "\(currentBill.paymentAmount)"
        dueDateLabel.text = "\(currentBill.dueDate.asString())"
        if currentBill.isPaid {
            paidLabel.text = "Paid"
        } else {
            paidLabel.text = "Unpaid"
        }
        
        //get notificatin thru indentyfier
        print("1 start")
        center.getPendingNotificationRequests(completionHandler: { (pendingNot) in
            for notification in pendingNot {
                print("2 durnig")
                if notification.identifier == currentBill.notificationIdentyfier {
                    DispatchQueue.main.async {
                        
                        self.notificationLabel.text = "\(notification.content) \(notification.trigger.debugDescription)"
                    }
                }
            }
            print("3 done")
        })
       print("4 exit")
        
        
    }
    
    
    func getBills(){
        guard let currentbill = bill else {return}
        for bill in BillsController.shared.bills {
            if bill.title == currentbill.title {
                someBills.append(bill)
            }
        }
        someBills = someBills.sorted(by: { (bill1, bill2) -> Bool in
            bill1.dueDate < bill2.dueDate
        })
    }
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someBills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? BillDetailTVC else {return UITableViewCell()}
        let currentBill = someBills[indexPath.row]
        cell.bill = currentBill
        
        return cell
    }
    
}
