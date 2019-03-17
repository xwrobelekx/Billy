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
    let timePicker = UIPickerView()
    let daysDelayPicker = UIPickerView()
    
    
    //MARK: - Outlets
    @IBOutlet weak var notificationDaysDelayTextField: UITextField!
    @IBOutlet weak var notificationTimeTextField: UITextField!
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self
        notificationTimeTextField.inputView = timePicker
        
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
        if pickerView == timePicker {
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timePicker {
            return 2
        } else if pickerView == daysDelayPicker {
            return 1
        }
        else {
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timePicker {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        notificationDaysDelayTextField.resignFirstResponder()
        notificationTimeTextField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == timePicker {
            switch component {
            case 0:
                SettingController.shared.setting.hour = DayAndTimeDelay.shared.hour[row]
            case 1:
                SettingController.shared.setting.minute = DayAndTimeDelay.shared.minute[row]
            default:
                print("no value")
            }
            notificationTimeTextField.text = "\(SettingController.shared.setting.hour):\(String(format: "%02d", SettingController.shared.setting.minute))"
            
        } else if pickerView == daysDelayPicker {
            SettingController.shared.setting.dayDelay = DayAndTimeDelay.shared.dayDelay[row]
            notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
        } else {
            print("no picker found")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
}
