import UIKit

@IBDesignable class UILikeButton: UIButton {
    
    @IBInspectable var unlikeImage: UIImage? {
        didSet {
            setupButton()
        }
    }
    @IBInspectable var likeImage: UIImage? {
        didSet {
            setupButton()
        }
    }
    
    @IBInspectable var likeStatus: Bool = false {
        didSet {
            setupButton()
        }
    }
    
    @IBInspectable var countLike: Int = 0 {
        didSet {
            setupButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        self.addTarget(self, action:#selector(buttonPressed(_:)), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        self.addTarget(self, action:#selector(buttonPressed(_:)), for: .touchDown)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupButton()
    }

    override var intrinsicContentSize: CGSize { CGSize(width: 64.0, height: 24.0) }
    
    
    private func setupButton() {
        self.setImage(likeStatus ? likeImage : unlikeImage, for: .normal)
        self.setTitle(countLike == 0 ? "" : String(countLike), for: .normal)
        self.setNeedsDisplay()
    }
    
    @objc private func buttonPressed (_ sender: Any) {
        countLike += (likeStatus ? -1 : 1)
        likeStatus = !likeStatus
        setupButton()
        flash()
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }

}
