//
//  AddBillVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/28/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class AddBillVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var payemntAmoutTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    //is it monthly - weekley - biwilkey - quarterley
    // full amout of loan / creadit to calculate when it ends
    //or add ending date
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        payemntAmoutTextField.delegate = self
        dueDateTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        payemntAmoutTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        return true
    }
    
    


    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "",
        let paymentAmout = payemntAmoutTextField.text, paymentAmout != "",
            let dueDate = dueDateTextField.text, dueDate != "" else {return}
        
        guard let payment = Double(paymentAmout) else {return}
        let bill = Bill(title: title, payementAmount: payment)
        BillsController.shared.create(bill: bill)
        

        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    

}
