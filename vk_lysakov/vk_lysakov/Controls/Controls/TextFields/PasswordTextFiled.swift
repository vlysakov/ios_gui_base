import UIKit

@IBDesignable class PasswordTextField: ValidateTextField {
    //internal variables
    private var secureImage : (show:UIImage?, hide:UIImage?) = (nil,nil)
    private var secureButton: UIButton = UIButton(frame: .zero)
    private var secureTextfieldMode : UITextField.ViewMode = .whileEditing
    
    public var getSecureButton : UIButton {
        get{
            return self.secureButton
        }
    }
    
    public var secureViewShowMode: UITextField.ViewMode = .whileEditing {
        didSet {
            secureTextfieldMode = secureViewShowMode
        }
    }
    
    @IBInspectable public var showImage: UIImage = UIImage() {
        didSet {
            secureImage.show = showImage
        }
    }
    @IBInspectable public var hideImage: UIImage = UIImage() {
        didSet {
            secureImage.hide = hideImage
        }
    }
    
    @available(*,unavailable)
    override public func awakeFromNib() {
        super.awakeFromNib()
        guard self.secureImage.show != nil && self.secureImage.hide != nil else {
            assert(false, "Provide a valid image for display for both show and hide, then try again")
        }
        self.addShowHideButton()
    }
       
    fileprivate func addShowHideButton() {
        
        let height = self.frame.size.height;
        let frame = CGRect(x: 0,y: 0, width: 0, height: height)
        
        secureButton.frame = frame
        secureButton.backgroundColor = .clear
        secureButton.setImage(secureImage.show, for: UIControl.State())
        secureButton.sizeToFit()
        secureButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        secureButton.addTarget(self, action: #selector(toggleShowPassword(_:)), for: UIControl.Event.touchUpInside)
        
        self.rightViewMode = secureTextfieldMode
        self.rightView = secureButton
        
    }
    
    @objc private func toggleShowPassword(_ sender:AnyObject) {
        let wasFirstResponder = false
        if wasFirstResponder == self.isFirstResponder {
            self.resignFirstResponder()
        }
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.applySwitchingWithAnimation()
    }
    
    private func applySwitchingWithAnimation() {
        secureButton.alpha = 0
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.secureButton.alpha = 1
            
            if self.isSecureTextEntry {
                self.secureButton.setImage(self.secureImage.show, for: UIControl.State())
            } else {
                self.secureButton.setImage(self.secureImage.hide, for: UIControl.State())
                self.attributedText = NSAttributedString(string: self.text!)
            }
        }, completion: nil)
    }
    
}
