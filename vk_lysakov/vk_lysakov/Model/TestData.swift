import UIKit


var usedGroups = [Group]()
var unusedGroups = [Group]()

class TestData {
    
    var users = [User]()
    
    static let data: TestData = {
        let instance = TestData()
        return instance
    }()
    
    private init() {
        let firstNames = ["Иван", "Петр", "Сергей", "Александр", "Юрий", "Семен", "Вячеслав", "Игорь", "Владимир", "Игорь"]
        let secondNames = ["Иванов", "Петров", "Сидоров", "Табуреткин", "Форточкин", "Ржевский", "Семенов", "Попов", "Смирнов", "Кузнецов"]
        let logins = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        for i in logins.indices {
            let u = User(login: logins[i], firstName: firstNames[i], secondName: secondNames[i], avatar: UIImage(named: String(format: "%02d", i+1)))
            u.foto = (0...5).map { _ in String(format: "%02d", Int.random(in: 1...16)) }
            users.append(u)
            
        }
        
        let myGroups = ["Группа 1", "Группа 2", "Группа 3", "Группа 4", "Группа 5", "Группа 6"]
        for i in 0...3 {
            usedGroups.append(Group(name: myGroups[i], image: UIImage(named: String(format: "%02d", 11 + i))))
        }
        for i in 4...5 {
            unusedGroups.append(Group(name: myGroups[i], image: UIImage(named: String(format: "%02d", 11 + i))))
        }
    }
    
}
