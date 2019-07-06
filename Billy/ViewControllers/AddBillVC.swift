//
//  AddBillVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/28/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class AddBillVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: - ask user if thay want to copy bill notes - or if they want to keep the notes in sync
    
    
    
    //MARK: - Properties
    var date: Date?
    let frequencyPicker = UIPickerView()
    var timeSelected: (hour: Int, minute: Int) = (8, 30)
    var daysDelay: Int = 0
     let datePicker = UIDatePicker()
    
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var payemntAmoutTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var paymentFrequency: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        payemntAmoutTextField.delegate = self
        dueDateTextField.delegate = self
        
        
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        paymentFrequency.inputView = frequencyPicker
        
        frequencyPicker.backgroundColor = #colorLiteral(red: 0.3590022922, green: 0.3760095537, blue: 0.3968008757, alpha: 0.5)
        
       
        datePicker.backgroundColor = #colorLiteral(red: 0.454691112, green: 0.4762320518, blue: 0.5025654435, alpha: 0.5)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        dueDateTextField.inputView = datePicker
    }
    
    
    
    //MARK: - TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        payemntAmoutTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        return true
    }
    
    

    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "",
            let paymentAmout = payemntAmoutTextField.text, paymentAmout != "",
            let dueDate = date else {return}
        
        guard let payment = Double(paymentAmout) else {return}
        let bill = NewBill(title: title, dueDate: dueDate, paymentAmount: payment, notificationIdentyfier: UUID().uuidString, notes: notesTextField.text)
        let frequency : BillFrequency? = BillFrequency(rawValue: paymentFrequency.text ?? "None")
        BillsController.shared.create(bill: bill, frequency: frequency)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dueDateTextField.text = formatter.string(from: sender.date)
        date = sender.date
        
        let curentDate = Calendar.current
        guard let  notificationDate =  curentDate.date(byAdding: .day, value: SettingController.shared.setting.dayDelay, to: Date()) else {return}
        
        if notificationDate < sender.date && notificationDate > Date(){
            infoLabel.isHidden = true
        } else {
            infoLabel.isHidden = false
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    //MARK: - Bill Frequancy Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == frequencyPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == frequencyPicker {
            return BillFrequency.allCases.count
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == frequencyPicker {
            return BillFrequency.allCases[row].rawValue
        } else {
            return "0"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == frequencyPicker {
            let selectedOption = BillFrequency.allCases[row]
            paymentFrequency.text = selectedOption.rawValue
        } else {
            print("no picker found")
        }
    }
    
    
    func clearTextFields(){
        titleTextField.text = ""
        payemntAmoutTextField.text = ""
        dueDateTextField.text = ""
        paymentFrequency.text = ""
        notesTextField.text = ""
    }
    
    
    func extractHourAndMinute(from time: String) -> (hour: Int, minute: Int){
        let colon = time.index(of: ":") ?? time.endIndex
        let hour = Int(time[..<colon])!
        let minute = Int(time[time.index(after: colon)...]) ?? 0
        return (hour, minute)
    }
    
    func confirmattionPopUpWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true)
    }
    
}
