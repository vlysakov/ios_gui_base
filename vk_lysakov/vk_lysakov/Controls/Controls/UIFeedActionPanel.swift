import UIKit

class UIFeedActionPanel: UIView {
    
    private var stackView = UIStackView()
    private var photoButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        setup()
        super.awakeFromNib()
    }
    
    private func setup() {
//        stackView = UIStackView()
        
//        if let sv = stackView {
//            sv.axis = .horizontal
//            sv.alignment = .fill
//            sv.distribution = .fill
//        }
        
    }

}
