//
//  TemporaryNotificationTVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/16/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications

//Temporary Table View Controller to see scheduled notifications

class TemporaryNotificationTVC: UITableViewController {
    
    let center = UNUserNotificationCenter.current()
    var pendingNotifications = [UNNotificationRequest](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    var deliveredNotifications = [UNNotification](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        center.getPendingNotificationRequests(completionHandler: { (pendingNot) in
            self.pendingNotifications = pendingNot
        })
        center.getDeliveredNotifications { (delivered) in
            self.deliveredNotifications = delivered
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return pendingNotifications.count
        case 1: return deliveredNotifications.count
        default: return 0
        }

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Pending"
        case 1: return "Delivered"
        default: return "Error"
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temporaryCell", for: indexPath)
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = pendingNotifications[indexPath.row].content.title
        cell.detailTextLabel?.text = pendingNotifications[indexPath.row].content.body
        case 1: cell.textLabel?.text = deliveredNotifications[indexPath.row].request.content.title
        cell.detailTextLabel?.text = deliveredNotifications[indexPath.row].request.content.body
        default: cell.textLabel?.text = "Error"
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
