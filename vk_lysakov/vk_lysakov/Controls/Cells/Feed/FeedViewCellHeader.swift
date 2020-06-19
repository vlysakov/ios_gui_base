import UIKit

class FeedViewCellHeader: UIView {
    
    private lazy var stackView = UIStackView()
    
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    var profileImageView: UIAvatarImageView = {
        let img = UIAvatarImageView()
        img.shadowOpacity = 15
        img.shadowRadius = 5
        img.cornerRadius = 15
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "help_circle_outline_28")
        img.backgroundColor = .systemBackground
        NSLayoutConstraint .activate([
            img.widthAnchor.constraint(equalToConstant: 30),
            img.heightAnchor.constraint(equalToConstant: 30)
        ])
        return img
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
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        fullNameLabel.text = "1234567890"
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(fullNameLabel)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint .activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
