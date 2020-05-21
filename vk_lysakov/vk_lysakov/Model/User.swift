import UIKit

class User {
    
    class Photo {
        let name: String
        var likeCount: Int
        var isLiked: Bool
        
        init (_ name: String, _ likeCount: Int = 0, _ isLiked: Bool = false) {
            self.name = name
            self.likeCount = likeCount
            self.isLiked = isLiked
        }
    }
    
    let login :String
    let firstName :String
    let secondName :String
    let avatar: UIImage?
    var fotos: [Photo] = [Photo]()
    
    var fullName: String { firstName + " " + secondName }
    
    init (login: String, firstName: String, secondName: String = "", avatar: UIImage? = nil) {
        self.login = login
        self.firstName = firstName
        self.secondName = secondName
        self.avatar = avatar
    }
    
}
