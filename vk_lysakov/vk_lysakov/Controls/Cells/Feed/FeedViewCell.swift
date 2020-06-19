import UIKit

class FeedViewCell: UICollectionViewCell {
    // MARK: Private
    var headerView = FeedViewCellHeader()
    var footerView = FeedViewCellFooter()
    var contentsView = FeedViewCellContent()
    private let stackView = UIStackView()
    
    // MARK: Overrides
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    func configureUI() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(contentsView)
        stackView.addArrangedSubview(footerView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint .activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
