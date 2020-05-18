//
//  UsersViewController.swift
//  vk_lysakov
//
//  Created by Slava V. Lysakov on 08.05.2020.
//  Copyright © 2020 Slava V. Lysakov. All rights reserved.
//

import UIKit

class UsersViewController: UITableViewController {
    
    var users = TestData.data.users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserViewCell
        
        cell.userNameLabel.text = users[indexPath.row].firstName + " " + users[indexPath.row].secondName
        cell.avatarImage.image = users[indexPath.row].avatar
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.height / 2
        cell.avatarImage.clipsToBounds = true
        #warning("чуть позде реализовать отдельным CALayer тени с округлением углов")
//        cell.avatarImage.layer.shadowColor = UIColor.black.cgColor
//        cell.avatarImage.layer.shadowOpacity = 0.5
//        cell.avatarImage.layer.shadowRadius = cell.avatarImage.frame.size.height / 16
//        cell.avatarImage.layer.shadowOffset = CGSize.zero
        cell.avatarImage.layer.masksToBounds = true
//        cell.avatarImage.backgroundColor = UIColor.darkGray
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showUserDetail" else { return }
        guard let dst = segue.destination as? UserDetailCollectionViewController else { return }
        if let userIndex = tableView.indexPathForSelectedRow {
            dst.user = users[userIndex.row]
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
