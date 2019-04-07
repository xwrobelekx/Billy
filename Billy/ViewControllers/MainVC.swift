//
//  MainVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/27/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MainBillCustomCellDelegate {
    
    //MARK: - Properties
    var pastDueBills = [NewBill]()
    var dueThisMonth = [NewBill]()
   // var paidBills = [NewBill]()
    var recentlyPaid = [NewBill]()
    
    //MARK: - Outlets
    @IBOutlet weak var curentDateLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curentDateLabel.text = Date().asStringLonger()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pastDueBills = BillsController.shared.filterBills(by: .isPastDue)
        dueThisMonth = BillsController.shared.filterBills(by: .isDueThisMonth)
     //   paidBills = BillsController.shared.filterBills(by: .isPaid)
        recentlyPaid = BillsController.shared.filterBills(by: .recentleyPaid)
        mainTableView.reloadData()
    }
    
    
    //MARK: - Table View Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomViewWithRoundedCorners()
        view.backgroundColor = .clear
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        switch section {
        case 0 :
            if pastDueBills.count == 0 && dueThisMonth.count == 0 {
                label.text = "No bills due this month."
            } else if pastDueBills.count >= 1 {
                label.text = "Past due bills:"
            } else {
                label.text = ""
            }
        case 1:
            if dueThisMonth.count == 0 {
                label.text = ""
            } else {
                label.text = "Bills due within a month:"
            }
        case 2:
            if recentlyPaid.count == 0 {
                label.text = ""
            } else {
                label.text = "Recently Paid:"
            }
        default:
            label.text = ""
        }
        label.frame = CGRect(x: 15, y: 5, width: 200, height: 20)
        view.addSubview(label)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pastDueBills.count
        case 1:
            return dueThisMonth.count
        case 2:
            return recentlyPaid.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell55", for: indexPath) as? MainViewTableViewCell else {return UITableViewCell()}
        
        cell.cellDelegate = self
        
        switch indexPath.section {
        case 0:
            cell.bill = pastDueBills[indexPath.row]
        case 1:
            cell.bill = dueThisMonth[indexPath.row]
        case 2:
            cell.bill = recentlyPaid[indexPath.row]
        default:
            print("no bill in main view cell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        //it takes them froll al of the bill insted of "due next week"
        
        switch indexPath.section {
        case 0:
            let bill = pastDueBills[indexPath.row]
            BillsController.shared.delete(bill: bill)
            pastDueBills.remove(at: indexPath.row)
            
        case 1:
            let bill = dueThisMonth[indexPath.row]
            BillsController.shared.delete(bill: bill)
            dueThisMonth.remove(at: indexPath.row)
            
        case 2:
            let bill = recentlyPaid[indexPath.row]
            BillsController.shared.delete(bill: bill)
            recentlyPaid.remove(at: indexPath.row)
            
        default : print("Error")
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let bill =
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let viewController = storyboard.instantiateViewController(withIdentifier: "GameCVC") as? GameCollectionViewController {
//           / viewController.tournamentName = turnament
//            viewController.round = round
//            viewController.navigationItem.title = round?.round.rawValue
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
        
 //   }
    
    
    //MARK: - Custom cell protocol conformance
    func billIsPaidToggle(cell: MainViewTableViewCell) {
        guard let bill = cell.bill else {return}
        guard let indexOfBill = BillsController.shared.bills.index(of: bill) else {return}
        BillsController.shared.bills[indexOfBill].isPaid.toggle()
    }
    
    
//    func modified(indexPath: IndexPath) -> Int {
//        return (indexPath.section * 2) + (indexPath.row)
//    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            guard let destinationVC = segue.destination as? DetailViewVC else {return}
            guard let indexPath = mainTableView.indexPathForSelectedRow else {return}
            switch indexPath.section {
            case 0:
                destinationVC.bill = pastDueBills[indexPath.row]
            case 1:
                destinationVC.bill = dueThisMonth[indexPath.row]
            default:
                print("Error")
                
            }
            //toDetailFromMonth
            
        }
    }
    
    

    
    
    
    
}
