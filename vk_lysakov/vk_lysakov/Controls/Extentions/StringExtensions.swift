import Foundation

extension Optional where Wrapped == String {
    func verification(_ expression:String?, required:Bool = false) -> Bool {
        if required && (self == nil || self == "") { return false }
        guard let text = self else { return true }
        guard text.count > 0 else { return true }
        guard let expression = expression else { return true } 
        
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", expression)
        let result = predicate.evaluate(with: self)
        return result
    }
}
