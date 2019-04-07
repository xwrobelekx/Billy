//
//  MonthVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit



class MonthVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   
    
   
    


    
    //this VC will hold a collection view which will hold each month - using the date it will open on current month

    //MARK: - Outlets
    @IBOutlet weak var monthCollectionView: UICollectionView!
    

    //MARK: - Properties
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        navigationController?.isNavigationBarHidden = true
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monthCollectionView.reloadData()
    }
    
    

    
    //MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = monthCollectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
        var totalToPay = 0.0
        let date = Calendar.current
        let months = date.monthSymbols
        let currentMoth = months[indexPath.row]
        let bills = BillsController.shared.filterBills(by: currentMoth)
        for bill in bills {
            totalToPay += bill.paymentAmount
        }
        cell.totalBillAmout = totalToPay
        cell.bills = bills
        cell.currentMonth = currentMoth
        return cell
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let date = Calendar.current
//        let months = date.monthSymbols
//        let currentMoth = months[indexPath.row]
//        guard let indexOfCurrentMonth = months.index(of: currentMoth) else {return}
//        let newIndexPath = IndexPath(row: indexOfCurrentMonth, section: indexPath.row)
//        self.monthCollectionView.scrollToItem(at: newIndexPath, at: .left, animated: false)
//
//    }
 
   
//    func presentDetailView(with bill: NewBill) {
//        //show the detail view with curent bill
//    
//    }


}
