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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amoutLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var billsTableView: UITableView!
    @IBOutlet weak var markPAidButton: UIButton!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editedTitle: UITextField!
    @IBOutlet weak var editedPaidLabel: UILabel!
    @IBOutlet weak var editedAmoutTextField : UITextField!
    @IBOutlet weak var editedDueDate: UILabel!
    @IBOutlet weak var editedNoted: UITextView!
    
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
        getBills()
        updateViews()
        billsTableView.delegate = self
        billsTableView.dataSource = self
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        editView.isHidden = true
    }
    
    
    
    //MARK: - Actions
    @IBAction func markPaidButtonPressed(_ sender: UIButton){
        hapticFeedback()
        guard let curentBill = bill else {return}
        curentBill.isPaid.toggle()
        updateViews()
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        hapticFeedback()
        guard let curentBill = bill else {return}
        let alert = UIAlertController(title: "Are you sure to delete this bill?", message: "This cannot be undone", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            BillsController.shared.delete(bill: curentBill)
            self.dismiss(animated: true, completion: nil)
            
        }))
        present(alert, animated: true)
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        hapticFeedback()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton){
        hapticFeedback()
        guard let currentBill = bill else {return}
        editedTitle.placeholder = currentBill.title
        if currentBill.isPaid {
        editedPaidLabel.text = "Paid"
        }else {
            editedPaidLabel.text = "Unpaid"
        }
        editedAmoutTextField.placeholder = "$\(currentBill.paymentAmount)"
        editedNoted.text = currentBill.notes
        animateViews()
        editedDueDate.text = "Due on: \(currentBill.dueDate.asString())"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton){
        hapticFeedback()
        guard let currentBill = bill else {return}
        animateViews()
        if let editedAmount = Double(editedAmoutTextField.text ?? String(
        currentBill.paymentAmount)) {
            if editedAmount != currentBill.paymentAmount {
                currentBill.paymentAmount = editedAmount
            }
        }
        if let editedTitle = editedTitle.text {
            currentBill.title = editedTitle
        }
        
        if let notes = editedNoted.text {
            currentBill.notes = notes
        }
        updateViews()
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let currentBill = bill else {return}
        titleLabel.text = currentBill.title
        amoutLabel.text = "\(currentBill.paymentAmount)"
        dueDateLabel.text = "Due on: \(currentBill.dueDate.asString())"
        if currentBill.isPaid {
            paidLabel.text = "Paid"
            markPAidButton.setTitle("Mark Unpaid", for: .normal)
        } else {
            paidLabel.text = "Unpaid"
            markPAidButton.setTitle("Mark Paid", for: .normal)
        }
        notes.text = currentBill.notes
        detailView.layer.opacity = 1
        editView.layer.opacity = 1
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
    
    
    func animateViews(){
        //if deatail view is visible
        if detailView.isHidden == false {
            self.editView.layer.opacity = 0
            self.detailView.layer.opacity = 1
            
            UIView.animate(withDuration: 1) {
                self.detailView.layer.opacity = 0
                
                self.editView.isHidden = !self.editView.isHidden
                self.detailView.isHidden = !self.detailView.isHidden
            }
            UIView.animate(withDuration: 1) {
                self.editView.layer.opacity = 1
            }
        } else {
            //if edit view is visible
            self.editView.layer.opacity = 1
            self.detailView.layer.opacity = 0
            
            UIView.animate(withDuration: 1) {
                self.editView.layer.opacity = 0
            }
            UIView.animate(withDuration: 1) {
                self.editView.isHidden = !self.editView.isHidden
                self.detailView.isHidden = !self.detailView.isHidden
                self.detailView.layer.opacity = 1
            }
        }
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let bill = someBills[indexPath.row]
        BillsController.shared.delete(bill: bill)
        someBills.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    //MARK: - Selectro Methods
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
