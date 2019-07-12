//
//  BillDetailVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/7/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications

class BillDetailVC: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    
    
    //MARK: - Preoperties
    var bill : NewBill? {
        didSet {
            print("bill updated")
        }
    }
    
    let center = UNUserNotificationCenter.current()
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        updateViews()
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
    
}
