//
//  MonthCollectionViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var billTableView: UITableView!
    @IBOutlet weak var monthNameLabel: UILabel!
    
    //create outlet to the tablw view which this cell holds - then implement same methods as in my other table view
    
    //each month has bills
    var currentMonth : Month? {
        didSet {
            //is this gone work?
        bills = currentMonth?.bills
            monthNameLabel.text = currentMonth?.name
        }
    }
    
    var bills : Bills?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        billTableView.delegate = self
        billTableView.dataSource = self
    }
    
    
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Past Due"
        case 1:
            return "Due this week"
        case 2:
            return "Due next week"
        case 3:
            return "Due this month"
        case 4:
            return "Paid"
        default:
            return "Not a valid section"
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return BillsController.shared.bills.count
        
        switch section {
        case 0:
            return BillsController.shared.filterBills(by: .isPastDue).count
        case 1:
            return BillsController.shared.filterBills(by: .isDueNextWeek).count
        case 2:
            return BillsController.shared.filterBills(by: .isDueInTwoWeeks).count
        case 3:
            return BillsController.shared.filterBills(by: .isDueThisMonth).count
        case 4:
            return BillsController.shared.filterBills(by: .isPaid).count
        default: return 0
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? BillTableViewCell else {return UITableViewCell()}
        
        // let bill = BillsController.shared.bills[indexPath.row]
      //  cell.cellDelegate = self
        
        
        switch indexPath.section {
        case 0:
            cell.billName.text = BillsController.shared.filterBills(by: .isPastDue)[indexPath.row].title
        case 1:
            cell.billName.text = BillsController.shared.filterBills(by: .isDueNextWeek)[indexPath.row].title
        case 2:
            cell.billName.text = BillsController.shared.filterBills(by: .isDueInTwoWeeks)[indexPath.row].title
        case 3:
            cell.billName.text = BillsController.shared.filterBills(by: .isDueThisMonth)[indexPath.row].title
        case 4:
            cell.billName.text = BillsController.shared.filterBills(by: .isPaid)[indexPath.row].title
        default:
            cell.billName.text = Bill(title: "Not a valid Bill", payementAmount: 111.11, paymentFrequency: "Anual", dueDate: Date()).title
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let bill = BillsController.shared.bills[indexPath.row]
            BillsController.shared.delete(bill: bill)
            tableView.reloadData()
            //this crashes
            // tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
