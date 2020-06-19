import UIKit

class GroupViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupViewCell", for: indexPath) as! GroupViewCell
        
        cell.groupNameLabel.text = usedGroups[indexPath.row].name
        cell.groupImageView.image = usedGroups[indexPath.row].image

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddGroupViewController else { return }
        destination.closure = { [weak self] group in
            usedGroups.append(group)
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let grp = usedGroups[indexPath.row]
            usedGroups.remove(at: indexPath.row)
            unusedGroups.append(grp)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
