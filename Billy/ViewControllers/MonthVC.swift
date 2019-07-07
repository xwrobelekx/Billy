//
//  MonthVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MonthVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    
    //this VC will hold a collection view which will hold each month - using the date it will open on current month

    //MARK: - Outlets
    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    var firstAppear = true
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self

        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width
        let cellHeight = screenSize.height
        let insetX = CGFloat(0)
        let insetY = CGFloat(0)
        let layout = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
     //   monthCollectionView.contentInset = UIEdgeInsets(top: CGFloat(20), left: insetX, bottom: CGFloat(50), right: insetX)
     
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
        let date = Calendar.current
        let month = date.monthSymbols
        let currentMoth = month[indexPath.row]
        let bills = BillsController.shared.filterBills(by: currentMoth)
        print("\(bills.count)")
        cell.bills = bills
        cell.currentMonth = currentMoth
        return cell
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if firstAppear == true {
            let currentMonthIndex = Date().monthAsInt()
            let indexToScroll = IndexPath(item: currentMonthIndex, section: 0)
            monthCollectionView.scrollToItem(at: indexToScroll, at: .left, animated: true)
            firstAppear = false
        }
    }
    
    
    
    
    
    
    


}
