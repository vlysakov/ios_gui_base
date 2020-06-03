import UIKit

class BigPhotoViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var startFrame: CGRect!
    
    private var closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "cancel_outline_28"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var likePanel: FeedViewCellFooter = {
        let p = FeedViewCellFooter()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.likeCount = Int.random(in: 0...100)
        p.likeStatus = Int.random(in: 0...1) == 0 ? true : false
        return p
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "06")
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .overCurrentContext
        self.transitioningDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        closeButton.isHidden = false
        likePanel.isHidden = false
    }
    
    override func loadView() {
        super.loadView()
        configureUI()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AnimatorDismiss(self.startFrame)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AnimatorPresent(self.startFrame)
    }
    
    private func configureUI() {
        //imageView
        self.view.addSubview(imageView)
        NSLayoutConstraint .activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            imageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
        closeButton.isHidden = true
        likePanel.isHidden = true
        self.view.addSubview(closeButton)
        NSLayoutConstraint .activate([
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchDown)
        //likePanel
        self.view.addSubview(likePanel)
        NSLayoutConstraint .activate([
            likePanel.heightAnchor.constraint(equalToConstant: 24),
            likePanel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            likePanel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            likePanel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    @objc private func closeButtonPressed (_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
