//
//  MonthCollectionViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit


//protocol presentDetailViewDelegate: class{
//    func presentDetailView(with bill: NewBill)
//}


class MonthCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource, MonthBillCustomCellDelegate {
  
    

    //MARK: - Outlets
    @IBOutlet weak var billTableView: UITableView!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var totalBillsAmountLabel: UILabel!
    
    
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
    
    var tableViewCellDelegate: MonthCollectionViewCell?
    var showDetailViewDelegate: MonthCollectionViewCell?
    var totalBillAmout : Double = 0.0 {
        didSet {
            totalBillsAmountLabel.text = "Total: $\(round(100*totalBillAmout)/100)"
        }
    }
    
   
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
   //     totalBillAmout = 0
        billTableView.delegate = self
        billTableView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
     //   totalBillAmout = 0
    }
    
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomViewWithRoundedCorners()
        view.backgroundColor = .clear
        let label = UILabel()
        label.text = "Bills for this month:"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.frame = CGRect(x: 0, y: 5, width: 200, height: 20)
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
        cell.monthDelegate = self
        guard let bills = bills else {
            return cell}
        let bill = bills[indexPath.row]
       // totalBillAmout += bill.paymentAmount
        cell.bill = bill
       // cell.billName.text = bill.title
      //  cell.billAmountLabel.text = "\(bill.paymentAmount)"
      //  cell.dueDateLabel.text = bill.dueDate.asString()
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let bill = BillsController.shared.bills[indexPath.row]
            #warning("implement delete method")
          //  totalBillAmout -= bill.paymentAmount
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let bills = bills else {return}
        let bill = bills[indexPath.row]
   //     showDetailViewDelegate.presentDetailView
//        showDetailViewDelegate call the method
//        let source = MonthVC()
//        let destinationVC = DetailViewVC()
//        guard let bills = bills else {return}
//        destinationVC.bill = bills[indexPath.row]
//        let segue = UIStoryboardSegue(identifier: "toDetailFromMonth", source: source, destination: destinationVC)
//         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        }
//        prepare(for: segue, sender: self)
//
        
//        let destinationModalVC = DetailViewVC()
//        guard let bills = bills else {return}
//        destinationModalVC.bill = bills[indexPath.row]
//       // self.present(destinationModalVC, animated: true)
//
        
        
        let destinationVC = DetailViewVC()
                destinationVC.bill = bills[indexPath.row]
        
     
        
    }
    
    //MARK: - Protocol conformance
    func billIsPaidToggleFor(bill: NewBill) {
        guard let indexOfBill = BillsController.shared.bills.index(of: bill) else {return}
        
        #warning("create if statement to checn if the bill is paid, and it it is then maybe pop an alert to ask user if they really want to mark the bill unpaid again ")
        
        BillsController.shared.bills[indexOfBill].isPaid.toggle()
    }
    
//    func showModally(){
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    if let viewController = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewVC {
//
//
//       // self.navigationController?.pushViewController(viewController, animated: true)
//    }
//
//    }

    
}
