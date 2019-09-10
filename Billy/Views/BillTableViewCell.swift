//
//  BillTableViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

protocol MonthBillCustomCellDelegate: class{
    func billIsPaidToggleFor(bill: NewBill)
}

class BillTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
<<<<<<< HEAD
    
    //MARK:  Properties
     var monthDelegate : MonthBillCustomCellDelegate?
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
=======
    @IBOutlet weak var dotLabel: UILabel!
>>>>>>> develop
    
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Actions
//    @IBAction func billIsCompletedButtonTapped(_ sender: Any) {
//        guard let bill = bill  else {return}
//       monthDelegate?.billIsPaidToggleFor(bill: bill)
//        updateViews()
//
//    }
    
    
    func updateViews(){
        guard let bill = bill else { return }
        billName.text = bill.title
        billAmountLabel.text = "\(bill.paymentAmount)"
        dueDateLabel.text = bill.dueDate.asString()
        
//        if bill.isPaid {
//            isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "Paid"), for: .normal)
//        } else {
//                isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "UnPaid"), for: .normal)
//        }
    }
    
    
}
