//
//  MonthCollectionViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var billTableView: UITableView!
    @IBOutlet weak var monthNameLabel: UILabel!
    
    
    
    //MARK: - Properties
    var currentMonth: String? {
        didSet {
            monthNameLabel.text = currentMonth
            billTableView.reloadData()
        }
    }
    
    
    var bills : [NewBill]? {
        didSet {
            billTableView.reloadData()
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
        view.backgroundColor = .clear
        let label = UILabel()
        label.textColor = .white
        label.text = "Bills for this month:"
        label.frame = CGRect(x: 15, y: 5, width: 200, height: 20)
        view.addSubview(label)
        return view
    }
    
    
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
        cell.billAmountLabel.text = "\(bill.paymentAmount)"
        cell.dueDateLabel.text = bill.dueDate.asString()
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bill = BillsController.shared.bills[indexPath.row]
            #warning("implement delete method")
            tableView.reloadData()
        }
    }
}
