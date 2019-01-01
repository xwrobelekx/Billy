//
//  MainViewTableViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/31/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {
    
    var bill: Bill? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var billTitle: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func isPaidButtonPressed(_ sender: Any) {
    }
    
    
    func updateViews(){
        guard let bill = bill else {return}
        billTitle.text = bill.title
    }
}
