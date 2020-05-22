import UIKit

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

@IBDesignable class UIShareButton: UIButton {
    
    var sharedImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.imageView?.image == nil {
            self.setImage(UIImage(named: "share_outline_24"), for: .normal)
        }
    }

    override var intrinsicContentSize: CGSize { CGSize(width: 64.0, height: 24.0) }
    
    
    @objc private func buttonPressed (_ sender: Any) {
        if let img = sharedImage {
            let shareController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
            self.parentViewController?.present(shareController, animated: true, completion: nil)
        }
    }
    
    func setupButton() {
        if self.imageView?.image == nil {
            self.setImage(UIImage(named: "share_outline_24"), for: .normal)
        }
        self.setTitle("", for: .normal)
        self.addTarget(self, action:#selector(buttonPressed(_:)), for: .touchDown)
    }
    
}
