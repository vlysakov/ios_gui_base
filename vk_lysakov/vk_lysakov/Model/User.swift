import UIKit

class User {
    let login :String
    let firstName :String
    let secondName :String
    let avatar: UIImage?
    var foto: [String]?
    
    var fullName: String { firstName + " " + secondName }
    
    init (login: String, firstName: String, secondName: String = "", avatar: UIImage? = nil) {
        self.login = login
        self.firstName = firstName
        self.secondName = secondName
        self.avatar = avatar
        self.foto = nil
    }
    
}
