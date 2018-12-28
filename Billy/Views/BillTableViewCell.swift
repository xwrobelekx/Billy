//
//  BillTableViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func billIsCompletedButtonTapped(_ sender: Any) {
    }
    
    
}
