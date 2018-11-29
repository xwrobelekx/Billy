//
//  BillCustomCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/28/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

protocol BillCustomCellDelegate: class{
    func billHasBeenPaidToggle(cell: UITableViewCell)
}


class BillCustomCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var billNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isPaidButton: UIButton!
    
    
    //MARK: - Properties
    var bill: Bill? {
        didSet {
            updateViews()
        }
    }
    var cellDelegate: BillCustomCellDelegate?
    

    //MARK: - LifeCycleMetods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isPaidButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let bill = bill else {return}
        billNameLabel.text = bill.title
        #warning("for now i have amout insted of due date, probaly gone need both")
        dueDateLabel.text = String(bill.payementAmount)
        
        if bill.isPaid {
            isPaidButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            isPaidButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
        
    }
    
    @IBAction func isPaidButtonTapped(_ sender: Any) {
        cellDelegate?.billHasBeenPaidToggle(cell: self)
    }
    
    

}
