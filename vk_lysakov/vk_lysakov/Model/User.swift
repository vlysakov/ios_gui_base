import UIKit

extension Array where Element : Hashable {
    var unique: [Element] { Array(Set(self)) }
}

extension Dictionary where Key : Comparable {
    var sortedKeys:  [Key]  { keys.map{$0} }
    subscript(index: Int) -> Value {
        return self[sortedKeys[index]]!
    }
}

class User: Hashable, Comparable {
    
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
    
    //MARK: - Hashable protocol
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.fullName.caseInsensitiveCompare(rhs.firstName) == .orderedSame
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(fullName)
    }
    
    
    //MARK: - Comparable protocol
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.secondName < rhs.secondName
    }

    
}
