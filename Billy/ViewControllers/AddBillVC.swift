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
    let datePicker = UIDatePicker()
    var deviceWidth : Int!
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var payemntAmoutTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var paymentFrequency: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceWidth = Int(self.view.frame.width)
        datePicker.backgroundColor = #colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1)
        datePicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
        datePicker.datePickerMode = .date
        
        updatePickers()
        
        titleTextField.delegate = self
        payemntAmoutTextField.delegate = self
        dueDateTextField.delegate = self
        
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
       

      //  updatePickers()
        
        
        datePicker.minimumDate = Date().addingTimeInterval(TimeInterval(SettingController.shared.setting.dayDelay * 86400))
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        dueDateTextField.inputView = datePicker
        paymentFrequency.inputView = frequencyPicker
         datePicker.backgroundColor = #colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  updatePickers()

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
        #warning("adjust the bill frequancy here")
        let frequency : BillFrequency? = BillFrequency(rawValue: paymentFrequency.text ?? "None")
        let bill = NewBill(title: title, dueDate: dueDate, paymentAmount: payment, notificationIdentyfier: UUID().uuidString, billUniqueIdentyfier: UUID().uuidString, billFrequency: frequency ?? BillFrequency.none, notes: notesTextView.text)
        BillsController.shared.create(bill: bill)
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
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    //MARK: - Bill Frequancy Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
      
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return BillFrequency.allCases.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return BillFrequency.allCases[row].rawValue
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            let selectedOption = BillFrequency.allCases[row]
            paymentFrequency.text = selectedOption.rawValue
      
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2486548013)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: deviceWidth, height: 50))
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = BillFrequency.allCases[row].rawValue
        
        view.addSubview(label)
        
        return view
    }
    

    
    
    
 
    
    
    func clearTextFields(){
        titleTextField.text = ""
        payemntAmoutTextField.text = ""
        dueDateTextField.text = ""
        paymentFrequency.text = ""
        notesTextView.text = ""
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
    
    
    func updatePickers(){
        #warning("sometimes it works sometimes it doesnt why?")
        // frequency picker background works once i stopped using opacity
        frequencyPicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
        frequencyPicker.backgroundColor = #colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1)
        
        datePicker.backgroundColor = #colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1)
        datePicker.setValue(#colorLiteral(red: 0.1338894367, green: 0.1373356879, blue: 0.4691907763, alpha: 1), forKey: "backgroundColor")
        datePicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
    }
    
}
