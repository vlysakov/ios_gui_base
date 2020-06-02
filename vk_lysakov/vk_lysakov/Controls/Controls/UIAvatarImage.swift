import UIKit

@IBDesignable class UIAvatarImageView: UIView {

    override var cornerRadius: CGFloat {
        didSet {
            layer.masksToBounds = !(self.cornerRadius > 0) //костыль
            self.layer.cornerRadius = self.cornerRadius
            layoutImage()
        }
    }
    
    // ImageView Attributes
    fileprivate var imageView = UIImageView()
    @IBInspectable var image: UIImage? { didSet {  layoutImage() } }
    @IBInspectable var imageContentMode: UIView.ContentMode = .scaleAspectFit { didSet { layoutImage() } }
    // Shadow Attributes
    @IBInspectable var shadowColor: UIColor = .black { didSet { dropShadow() } }
    @IBInspectable var shadowOpacity: Float = 0.0 { didSet { dropShadow() } }
    @IBInspectable var shadowRadius: CGFloat = 0.0 { didSet { dropShadow() } }
    @IBInspectable var shadowOffset: CGSize = .zero { didSet { dropShadow() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        layoutImage()
        dropShadow()
    }
    
    fileprivate func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    fileprivate func layoutImage() {
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
        self.addSubview(imageView)
        imageView.image = self.image
        imageView.contentMode = self.contentMode
        imageView.layer.cornerRadius = self.layer.cornerRadius
        imageView.layer.masksToBounds = true
    }
    
    fileprivate func dropShadow() {
        if traitCollection.userInterfaceStyle == .dark {
            self.layer.shadowColor = UIColor.lightGray.cgColor
        } else {
            self.layer.shadowColor = shadowColor.cgColor
        }
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    @objc func tapAction() {
        print("Yes!!!")
        UIView .animate(withDuration: 0.75,
                        animations: {
                            self.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
                        },
                        completion: { (finish) in
                                    UIView.animate(withDuration: 0.75, animations: {
                                    self.transform = CGAffineTransform.identity
                                })
                        })

    }
    
}
