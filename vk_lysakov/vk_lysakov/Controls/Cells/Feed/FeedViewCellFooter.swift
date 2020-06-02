import UIKit

class FeedViewCellFooter: UIView {
    private let stackView = UIStackView()
    private let likeImage: UIImage? = UIImage(named: "liked_outline_24")
    private let unlikeImage: UIImage? = UIImage(named: "like_outline_24")
    
    public var likeCount = 0 {
        didSet {
            print("likeCount = "+String(likeCount))
            likeButton.setTitle(likeCount == 0 ? "" : String(likeCount), for: .normal)
        }
    }
    
    public var likeStatus = false {
        didSet {
            likeButton.setImage(likeStatus ? likeImage : unlikeImage, for: .normal)
        }
    }
    
    private lazy var likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(unlikeImage, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private lazy var shareButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("123", for: .normal)
        btn.setImage(UIImage(named: "share_outline_24"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private lazy var commentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("123", for: .normal)
        btn.setImage(UIImage(named: "comment_outline_24"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private lazy var viewsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("123", for: .normal)
        btn.setImage(UIImage(named: "view_24"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.setTitleColor(.systemGray, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        likeButton.addTarget(self, action:#selector(likeButtonPressed(_:)), for: .touchDown)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(viewsButton)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint .activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func likeButtonPressed (_ sender: Any) {
        likeCount += (likeStatus ? -1 : 1)
        likeStatus = !likeStatus
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        likeButton.layer.add(flash, forKey: nil)
    }
    
}
