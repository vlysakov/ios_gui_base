import UIKit

class AddGroupViewController: UITableViewController {
    
    var closure: ((Group) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unusedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddGroupViewCell", for: indexPath) as! AddGroupViewCell

        cell.groupNameLabel.text = unusedGroups[indexPath.row].name
        cell.groupImageView.image = unusedGroups[indexPath.row].image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = unusedGroups[indexPath.row]
        unusedGroups.remove(at: indexPath.row)
        navigationController?.popViewController(animated: true)
        closure?(group)
    }

}
