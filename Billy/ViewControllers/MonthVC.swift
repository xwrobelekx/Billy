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
    
     // var cellScaling : CGFloat = 0.95
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
       // monthCollectionView.collectionViewLayout
        //collectionViewLayout.minimumLineSpacing = 0
//        monthCollectionView.isPagingEnabled = true
//        
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScaling)
//        let cellHeight = floor(screenSize.height * cellScaling)
//        
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//        
//        let layout = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        monthCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
     
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
        //let month = MonthController.shared.months[indexPath.row]
        let date = Calendar.current
        let month = date.monthSymbols
        let currentMoth = month[indexPath.row]
        let bills = BillsController.shared.filterBills(by: currentMoth)
        print("\(bills.count)")
        cell.bills = bills
        cell.currentMonth = currentMoth
        return cell
    }
    
    
//    public func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    
    
    
 


}
