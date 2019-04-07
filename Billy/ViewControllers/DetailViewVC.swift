//
//  DetailViewVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/17/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class DetailViewVC: UIViewController {
    
    
    //MARK: - Properties
    var bill : NewBill? {
        didSet {
           print("➡️ bill set")
          //  updateViews()
        }
    }
    
    var newDate: Date?
     let datePicker = UIDatePicker()
    
    
    
    //MARK: - Outlets
    
    //Show Bill Detail Outlets
    
    @IBOutlet weak var showBillDetailsView: CustomViewWithRoundedCorners!
    @IBOutlet weak var billTitleLabel: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var billDueDateLabel: UILabel!
    @IBOutlet weak var noteLabel: UITextView!
    @IBOutlet weak var dismissButtonOutlet: UIButton!
    @IBOutlet weak var paidLabel: UILabel!
    
    //Edit Bill View Outlets
    @IBOutlet weak var editBillView: CustomViewWithRoundedCorners!
    @IBOutlet weak var newBillTitleTextField: UITextField!
    @IBOutlet weak var newBillAmoutTextField: UITextField!
    @IBOutlet weak var newDueDateTextField: UITextField!
    @IBOutlet weak var newNoteTextField: UITextField!
    @IBOutlet weak var numberOfBillsLabel: UILabel!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var updateAllBillSwitch: UISwitch!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showBillDetailsView.isHidden = false
        editBillView.isHidden = true
        saveButtonOutlet.isEnabled = false
        dismissButtonOutlet.isEnabled = true
        
        
        updateAllBillSwitch.isOn = false
        updateAllBillSwitch.onTintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1)
        datePicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePicker.minimumDate = Date().addingTimeInterval(TimeInterval(SettingController.shared.setting.dayDelay * 86400))
        newDueDateTextField.inputView = datePicker
        
        print("➡️ view loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("➡️ view appeared")
        updateViews()
    }
    
    
    //MARK: - Actions
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        //flip labes to textfields with pre-populated fields - keeping the reference to existing bill
        
        flipViews()
        
        
        
        
        
        print("➡️ update button pressed")
      //  updateViews()
    }
    
    //MARK: - Helper methods
    
    func updateViews() {
        print("➡️ update method called")
        guard let bill = bill else {
            print("➡️ no bill found - returning ")
            return}
        print("➡️ setting bill with title: \(bill.title)")
        guard let titleLabel = billTitleLabel else {
            print("➡️ no title label found - returning")
            return}
        billTitleLabel.text = bill.title
        billAmountLabel.text = "$\(bill.paymentAmount)"
        billDueDateLabel.text = "\(bill.dueDate.asStringLonger())"
        noteLabel.text = bill.notes
        
        
        newBillTitleTextField.text = bill.title
        newBillAmoutTextField.placeholder = "$\(bill.paymentAmount)"
        newDueDateTextField.placeholder = bill.dueDate.asStringLonger()
        newNoteTextField.text = bill.notes
        
        if bill.isPaid {
             print("➡️ settig paid label")
            paidLabel.text = "Paid"
            paidLabel.textColor = #colorLiteral(red: 0, green: 0.8684847951, blue: 0.4671590328, alpha: 1)
        } else {
            print("➡️ settig unpaid label")
            paidLabel.text = "Unpaid"
            paidLabel.textColor = #colorLiteral(red: 0.8713001609, green: 0.2077551484, blue: 0.2785714269, alpha: 1)
        }
        
        let billCount = BillsController.shared.returnNumberOfSameBills(as: bill)
        if billCount == 0 {
            numberOfBillsLabel.text = "There is only one bill with this title"
        } else {
            numberOfBillsLabel.text = "There is \(billCount) bills with the same title."
        }
        
        print("➡️ update method finished")
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        newDueDateTextField.text = formatter.string(from: sender.date)
        newDate = sender.date
    }
    
    //MARK: - Edit View Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let oldBill = bill else {return}
        
        guard let title = newBillTitleTextField.text, title != "" else {return}
        let billAmount = Double(newBillAmoutTextField.text!)
        
        
        
        let newBill = NewBill(title: title, dueDate: newDate ?? oldBill.dueDate, paymentAmount: billAmount ?? oldBill.paymentAmount, isPaid: oldBill.isPaid, notificationIdentyfier: oldBill.notificationIdentyfier, billUniqueIdentyfier: oldBill.billUniqueIdentyfier, billFrequency: oldBill.billFrequency, notes: newNoteTextField.text)
        
        BillsController.shared.update(bill: newBill, updateAllBills: updateAllBillSwitch.isOn)
        flipViews()
        //update existing bill
        updateViews()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        flipViews()
    }
    
    func flipViews(){
        UIView.animate(withDuration: 0.5, animations: {
            #warning("animation not working")
            self.showBillDetailsView.isHidden = !self.showBillDetailsView.isHidden
            self.editBillView.isHidden = !self.editBillView.isHidden
            self.saveButtonOutlet.isEnabled = !self.saveButtonOutlet.isEnabled
            self.dismissButtonOutlet.isEnabled = !self.dismissButtonOutlet.isEnabled
        })

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
