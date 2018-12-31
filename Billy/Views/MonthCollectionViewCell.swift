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
      //  bills = currentMonth?.bills
            monthNameLabel.text = currentMonth?.name
            print("🀄️🇵🇱🇵🇱🇵🇱🇵🇱")
            billTableView.reloadData()
        }
    }
    
   // var bills : Bills?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        billTableView.delegate = self
        billTableView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // currentMonth = nil
        print("🔳 preparing for reuse month: \(currentMonth?.name)")
      //  billTableView.reloadData()
        
    }
    
    
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // switch back to 5 later
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bills for this month:"

    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return BillsController.shared.bills.count
        

        guard let month = currentMonth else {
            print("🔴 Returning zero")
            return 0}
        #warning("Lots of bangs - keep an eye on them")
        
    
        
        
        
        print("🔵 count: \(BillsController.shared.filterBills(by: Year(rawValue: month.name!)!).count)")
        return BillsController.shared.filterBills(by: Year(rawValue: month.name!)!).count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? BillTableViewCell else {return UITableViewCell()}
        guard let month = currentMonth else {
            print("🔴 No Cell")
            return cell}
        
     //   print("🌈 \(month.name)")
      //  print("☀️\(indexPath.row)")
        
        let bill = BillsController.shared.filterBills(by: Year(rawValue: month.name!)!)[indexPath.row]
   //     print("🇦🇸 \(bill.title)")
        cell.billName.text = bill.title
        cell.billAmountLabel.text = "\(bill.payementAmount)"
        cell.dueDateLabel.text = bill.dueDate?.asString()
        
        
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
