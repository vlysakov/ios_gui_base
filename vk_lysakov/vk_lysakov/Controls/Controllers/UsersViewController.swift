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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return users.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserViewCell
        
        cell.userNameLabel.text = users[indexPath.section].1[indexPath.row].fullName
        cell.avatarImageView.image = users[indexPath.section].1[indexPath.row].avatar
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showUserDetail" else { return }
        guard let dst = segue.destination as? UserDetailCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            dst.user = users[indexPath.section].1[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return users[section].0
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return users.map{$0.0}
    }

}
