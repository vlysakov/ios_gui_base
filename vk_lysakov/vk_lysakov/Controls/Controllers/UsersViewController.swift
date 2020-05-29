import UIKit

class UsersViewController: UITableViewController, UISearchBarDelegate {
    
    var data = TestData.data.users
    var users: [String:[User]] = [:]
    
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        //tableView.tableHeaderView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        self.tableView.contentInset.bottom = self.tabBarController?.tabBar.frame.height ?? 0
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return users.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users[sections[section]]?.count ?? 0
        return users[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserViewCell
        
        //        if let usr = users[sections[indexPath.section]]?[indexPath.row] {
        let usr = users[indexPath.section][indexPath.row]
        cell.userNameLabel.text = usr.fullName
        cell.avatarImageView.image = usr.avatar
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showUserDetail" else { return }
        guard let dst = segue.destination as? UserDetailCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            dst.user = users[indexPath.section][indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return users.sortedKeys[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return users.sortedKeys
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loadData(searchText)
        tableView.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.view.endEditing(true)
        searchBar.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
//        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
//        self.view.endEditing(true)
    }

    func loadData(_ searchText: String? = nil) {
        var dt: [User]
        users.removeAll()
        if let str = searchText?.uppercased() {
            dt = searchText == "" ? data : data.filter{$0.fullName.uppercased().contains(str)}
        } else {
            dt = data
        }
        let sections = dt.map{($0.secondName.first?.uppercased())!}.unique.sorted()
        sections.forEach { ch in users[ch] = dt.filter{$0.secondName.first?.uppercased() == ch} }

    }

}

