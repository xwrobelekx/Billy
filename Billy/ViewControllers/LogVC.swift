//
//  LogVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/29/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class LogVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    let datePicker = UIDatePicker()
    
    
    //MARK: - Outlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    
    //MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        dateTextField.inputView = datePicker
        amountTextField.delegate = self
        categoryTextField.delegate = self
        

      
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)

    }
    
    
    //MARK: - Actions
    @IBAction func doneButtonPRessed(sender: UIButton){
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed( sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
