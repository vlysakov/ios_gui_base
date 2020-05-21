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
    }

}
