//
//  MainVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/27/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    
    @IBOutlet weak var curentDateLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        curentDateLabel.text = Date().asStringLonger()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "Past Due Bills:"
        case 1:
            return "Due Next Week:"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
           return BillsController.shared.filterBills(by: .isPastDue).count
        case 1:
            return BillsController.shared.filterBills(by: .isDueNextWeek).count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell55", for: indexPath) as? MainViewTableViewCell else {return UITableViewCell()}
        
        switch indexPath.section {
        case 0:
            cell.bill = BillsController.shared.filterBills(by: .isPastDue)[indexPath.row]
        case 1:
            cell.bill = BillsController.shared.filterBills(by: .isDueNextWeek)[indexPath.row]
        default:
            print("no bill in main view cell")
        }
        return cell
    }
    
    
    
    
    

}
