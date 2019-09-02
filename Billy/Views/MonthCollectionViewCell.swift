//
//  MonthCollectionViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

protocol MonthCellCustomDelegate: class{
    func presentDetailViewWith(bill: NewBill)
}


class MonthCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var billTableView: UITableView!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    //MARK: - Properties
    var currentMonth: String? {
        didSet {
            monthNameLabel.text = currentMonth
            billTableView.reloadData()
        }
    }
    
    var monthDelegate: MonthCellCustomDelegate?
    
    
    var bills : [NewBill]? {
        didSet {
            billTableView.reloadData()
            updateTotalDue()
        }
    }
    
    
    
    
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        billTableView.delegate = self
        billTableView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomViewWithRoundedCorners()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        let label = UILabel()
        label.textColor = .white
        label.text = "Bills for this month:"
        label.font = UIFont(name: "Marker Felt", size: 17)
        label.frame = CGRect(x: 15, y: 5, width: 200, height: 20)
        view.addSubview(label)
        return view
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = CustomViewWithRoundedCorners()
//        view.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.2392156863, blue: 0.2509803922, alpha: 1)
//        let label = UILabel()
//        label.textColor = .white
//        label.textAlignment = .right
//        label.text = "Total due this month: \(totalDue)"
//        label.font = UIFont(name: "Marker Felt", size: 17)
//        label.frame = CGRect(x: 15, y: 5, width: billTableView.bounds.width - 20, height: 20)
//        view.addSubview(label)
//        return view
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let bills = bills else {return 0}
        return bills.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? BillTableViewCell else {return UITableViewCell()}
        guard let bills = bills else {
            return cell}
        let bill = bills[indexPath.row]
        cell.billName.text = bill.title
        cell.billAmountLabel.text = "\(bill.paymentAmount.roundToDecimal(2))"
        cell.dueDateLabel.text = bill.dueDate.dayAndMonthAsString()
        if bill.isPaid {
            cell.dotLabel.textColor = .green
        } else {
            cell.dotLabel.textColor = .red
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        guard let curentBills = bills else {return}
    //        let bill = curentBills[indexPath.row]
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? BillDetailVC else {return}
    //        detailVC.bill = bill
    //wont work because table view is inside of a collection cell and it doesnt have "present"
    //       // present(detailVC, animated: true)
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bills = bills else {return}
        let bill = bills[indexPath.row]

        
        monthDelegate?.presentDetailViewWith(bill: bill)
   
    
   //     UINavigationController.present(detailVC)
  //      present(detailVC, animated: true)
    }
    
    
    
    
    // Override to support editing the table view.
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            let bill = BillsController.shared.bills[indexPath.row]
    //            #warning("implement delete method")
    //            tableView.reloadData()
    //        }
    //    }
    
    
    func updateTotalDue(){
        var totalToPay : Double = 0
        guard let bills = bills else {return}
        for bill in bills {
            totalToPay += bill.paymentAmount
        }
        totalLabel.text = "Total due for this month: $\(totalToPay.roundToDecimal(2))"
    }
}
