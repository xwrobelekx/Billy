//
//  SettingsViewController.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/9/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    //MARK: - Properties
    let daysDelayPicker = UIPickerView()
    
    
    //MARK: - Outlets
    @IBOutlet weak var notificationDaysDelayTextField: UITextField!
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet var timeAndDatePicker: UIDatePicker!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeAndDatePicker.datePickerMode = .time
        
        
        notificationTimeTextField.inputView = timeAndDatePicker
        
        daysDelayPicker.delegate = self
        daysDelayPicker.dataSource = self
        notificationDaysDelayTextField.inputView = daysDelayPicker
        
        notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
        notificationTimeTextField.text = "\(SettingController.shared.setting.hour):\(String(format: "%02d", SettingController.shared.setting.minute))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SettingController.shared.saveSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SettingController.shared.loadSettings()
    }
    
    
    //MARK: - Actions
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        SettingController.shared.setting.hour = 8
        SettingController.shared.setting.minute = 30
        SettingController.shared.setting.dayDelay = 5
        
        notificationTimeTextField.text = "\(SettingController.shared.setting.hour):\(SettingController.shared.setting.minute)"
        notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
    }
    
    
    
    //MARK: - UIPicker Delegate methods
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return DayAndTimeDelay.shared.dayDelay.count
 
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1

    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(DayAndTimeDelay.shared.dayDelay[row])"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        notificationDaysDelayTextField.resignFirstResponder()
        notificationTimeTextField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("🔵 im here 2")
            SettingController.shared.setting.dayDelay = DayAndTimeDelay.shared.dayDelay[row]
            notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"

    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func timePickerValueChabged(_ sender: UIDatePicker){
        SettingController.shared.setting.hour = timeAndDatePicker.date.hour()
        SettingController.shared.setting.minute = timeAndDatePicker.date.minute()
        print("🍀\(timeAndDatePicker.date.timeAsString())")
             notificationTimeTextField.text = "\(timeAndDatePicker.date.timeAsString())"
    }
    
    
}
