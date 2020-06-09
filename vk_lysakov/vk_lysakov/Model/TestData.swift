import UIKit


var usedGroups = [Group]()
var unusedGroups = [Group]()

class TestData {
    
    var users = [User]()
//    var users = [(String,[User])]()
    
    static let data: TestData = {
        let instance = TestData()
        return instance
    }()
    
    private init() {
        let firstNames = ["Иван", "Петр", "Сергей", "Александр", "Юрий", "Семен", "Вячеслав", "Игорь", "Владимир", "Игорь"]
        let secondNames = ["Иванов", "Петров", "Сидоров", "Табуреткин", "Форточкин", "Ржевский", "Семенов", "Попов", "Смирнов", "Кузнецов"]
        let logins = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        let tu = User(login: "0", firstName: "Тестовый", secondName: "пользователь", avatar: UIImage(named: "01")!)
        tu.fotos.append(User.Photo("06"))
        users.append(tu)
        let tu1 = User(login: "11", firstName: "Тестовый", secondName: "пользователь 2", avatar: UIImage(named: "02")!)
        tu1.fotos.append(User.Photo("09"))
        tu1.fotos.append(User.Photo("10"))
        users.append(tu1)
        for i in logins.indices {
            let u = User(login: logins[i], firstName: firstNames[i], secondName: secondNames[i], avatar: UIImage(named: String(format: "%02d", i+1)))
            u.fotos = (0...Int.random(in: 1...16)).map { _ in String(format: "%02d", Int.random(in: 1...16)) }
                .map{ name in User.Photo(name, Int.random(in: 0...100), Int.random(in: 0...1) != 0 ? false : true) }
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
