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
    //    var pickers = [UIPickerView]()
    let frequencyPicker = UIPickerView()
    let timePicker = UIPickerView()
    let daysDelayPicker = UIPickerView()
    var timeSelected: (hour: Int, minute: Int) = (8, 30){
        didSet {
            notificationTimeTextField.text = "\(timeSelected.hour):\(timeSelected.minute)"
        }
    }
    var daysDelay: Int = 0 {
        didSet{
            notificationDayDelayTextField.text = "\(daysDelay)"
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var payemntAmoutTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var paymentFrequency: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var notificationDayDelayTextField: UITextField!
    @IBOutlet weak var notificationTimeTextField: UITextField!
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        payemntAmoutTextField.delegate = self
        dueDateTextField.delegate = self
        
        
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        paymentFrequency.inputView = frequencyPicker
        
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .green //not doing anything the first time is being used
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        dueDateTextField.inputView = datePicker
        
        
        timePicker.delegate = self
        timePicker.dataSource = self
        notificationTimeTextField.inputView = timePicker
        
        
        daysDelayPicker.delegate = self
        daysDelayPicker.dataSource = self
        notificationDayDelayTextField.inputView = daysDelayPicker
        
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
        let bill = Bill(title: title, payementAmount: payment, dueDate: dueDate, notes: notesTextField.text)
        print("🚀\(paymentFrequency.text!)") //confirms selected frequancy in debugger when saving the bill
        
        //need to take the string and get the case value for the raw value
        guard let frequancy : BillFrequency = BillFrequency(rawValue: paymentFrequency.text ?? "None") else {return}
        
        BillsController.shared.create(bill: bill, frequency: frequancy)
        
        
        NotificationController.shared.setupCustomNotificationWith(title: "\(title) is due in \(daysDelay) days.", message: "Payment of $\(paymentAmout) is due on \(dueDate.asString()).", billDueDate: dueDate, daysDelay: daysDelay, atHour: timeSelected.hour, atMinute: timeSelected.minute)
        
        
        confirmattionPopUpWith(title: "Bill Saved", message: "Your bill named: \(title) with amount of $\(paymentAmout) was succesfully crerated with \(frequancy) frequency. You will be notified \(daysDelay) days before due date, at \(timeSelected.hour):\(timeSelected.minute)")
        
        clearTextFields()
        
        //   tabBarController?.present(MainVC(), animated: true, completion: nil)
        
    }
    
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dueDateTextField.text = formatter.string(from: sender.date)
        date = sender.date
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    //MARK: - Bill Frequancy Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == frequencyPicker {
            return 1
        } else if pickerView == timePicker {
            return 2
        } else if pickerView == daysDelayPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == frequencyPicker {
            return BillFrequency.allCases.count
        } else if pickerView == timePicker {
            switch component {
            case 0:
                return DayAndTimeDelay.shared.hour.count
            case 1:
                return DayAndTimeDelay.shared.minute.count
            default:
                return 0
            }
        } else if pickerView == daysDelayPicker {
            return DayAndTimeDelay.shared.dayDelay.count
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == frequencyPicker {
            return BillFrequency.allCases[row].rawValue
        } else if pickerView == timePicker {
            switch component {
            case 0:
                return "\(DayAndTimeDelay.shared.hour[row])"
            case 1:
                return "\(DayAndTimeDelay.shared.minute[row])"
            default:
                return "0"
            }
        } else if pickerView == daysDelayPicker {
            return "\(DayAndTimeDelay.shared.dayDelay[row])"
        } else {
            return "0"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == frequencyPicker {
            let selectedOption = BillFrequency.allCases[row]
            paymentFrequency.text = selectedOption.rawValue
        } else if pickerView == timePicker {
            switch component {
            case 0:
                timeSelected.hour = DayAndTimeDelay.shared.hour[row]
            case 1:
                timeSelected.minute = DayAndTimeDelay.shared.minute[row]
            default:
                print("no value")
            }
            //  notificationTimeTextField.text = "\(timeSelected.hour):\(timeSelected.minute)"
            
        } else if pickerView == daysDelayPicker {
            daysDelay = DayAndTimeDelay.shared.dayDelay[row]
            //   notificationDayDelayTextField.text = "\(daysDelay)"
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
        daysDelay = 5
        timeSelected = (8, 30)
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
            
        }))
        
        present(alert, animated: true)
    }
    
}
