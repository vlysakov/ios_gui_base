import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBInspectable var transparent: Bool = false {
        didSet {
            setTransparentTabbar(mode: transparent)
        }
    }
    
    func setTransparentTabbar(mode: Bool) {
        UITabBar.appearance().backgroundImage = mode ? UIImage() : nil
        UITabBar.appearance().shadowImage     = mode ? UIImage() : nil
        UITabBar.appearance().clipsToBounds   = mode
    }
    
}
