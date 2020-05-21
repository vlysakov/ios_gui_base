import UIKit

extension UIView {
    
    @IBInspectable public var borderColor:UIColor? {
        get {
            if let color = self.layer.borderColor {
                return  UIColor(cgColor: color)
            }
            return .black
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
       
    @IBInspectable public var borderWidth:CGFloat {
           get { self.layer.borderWidth }
           set {
               self.layer.borderWidth = newValue
            }
       }
    
       @IBInspectable public var cornerRadius:CGFloat {
           get { layer.cornerRadius }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
       }
}


