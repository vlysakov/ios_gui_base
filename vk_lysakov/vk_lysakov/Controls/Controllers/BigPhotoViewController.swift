import UIKit

enum AnimationDirection {
    case left
    case right
}

class BigPhotoViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {
    //MARK: Variables and properties
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
    
    var index = 0
    var images = [UIImage]()
    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
    var imageView2: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private var propertyAnimator: UIViewPropertyAnimator!
    private var animationDirection: AnimationDirection = .left
    private var panGR: UIPanGestureRecognizer!
    private var downSwipeGR: UISwipeGestureRecognizer!
    
    //MARK: Initializers
    convenience init(images: [UIImage], index: Int) {
        self.init()
        self.images = images
        self.index = index
        self.imageView.image = self.images[self.index]
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = .systemBackground
    }
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        panGR.delegate = self
        panGR.maximumNumberOfTouches = 2
        downSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        downSwipeGR.delegate = self
        downSwipeGR.direction = .down
        view.addGestureRecognizer(panGR)
        view.addGestureRecognizer(downSwipeGR)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        closeButton.isHidden = false
        likePanel.isHidden = false
        imageView2.isHidden = false
        imageView.image = images[index]
    }
    
    override func loadView() {
        super.loadView()
        configureUI()
    }
    
    private func configureUI() {
        //imageView
        self.view.addSubview(imageView)
        NSLayoutConstraint .activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        ])

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
        self.view.insertSubview(imageView2, belowSubview: imageView)
        NSLayoutConstraint.activate([
            imageView2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageView2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView2.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageView2.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        imageView2.isHidden = true
        closeButton.isHidden = true
        likePanel.isHidden = true
    }
    
    
    //MARK: UIViewControllerTransitioningDelegate
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AnimatorDismiss(self.startFrame)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AnimatorPresent(self.startFrame)
    }

    //MARK: Exite methods
    @objc private func closeButtonPressed (_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func swipeDown(_ recognizer: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
       if gestureRecognizer == self.panGR! && otherGestureRecognizer == self.downSwipeGR! {
          return true
       }
       return false
    }
    
    //MARK: Animation methods
    @objc func viewPanned(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animationDirection = recognizer.velocity(in: self.view).x > 0 ? .right : .left
            let flag = CGFloat(animationDirection == .left ? -1 : 1)
            guard (index >= 1 && animationDirection == .right) || (index + 1 < images.count && animationDirection == .left) else {
                propertyAnimator = nil
                return
            }
            imageView2.transform = CGAffineTransform(translationX: -flag*self.imageView2.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            imageView2.image = images[index + Int(-flag)]
            propertyAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut)
            propertyAnimator.addAnimations{
                self.imageView.transform = CGAffineTransform(translationX: flag*self.imageView.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 0.7, y: 0.7))
                self.imageView2.transform = .identity
        }
            propertyAnimator.addCompletion { position in
                switch position {
                case .end:
                    let i = self.index - Int(flag)
                    guard i >= 0 && i < self.images.count else { return }
                    self.index -= Int(flag)
                    self.imageView.image = self.images[self.index]
                    self.imageView.transform = .identity
                    self.imageView2.image = nil
                case .start:
                    self.imageView2.transform = CGAffineTransform(translationX: -flag*self.imageView2.bounds.width, y: 0).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                case .current:
                    break
                @unknown default:
                    break
                }
            }
            propertyAnimator.startAnimation()
        case .changed:
            guard let pa = self.propertyAnimator else { return }
            pa.fractionComplete = min(max(0, abs(recognizer.translation(in: self.view).x) / self.view.bounds.width), 1)//* (animationDirection == .left ? -1 : 1)
        case .ended:
            guard let pa = self.propertyAnimator else { return }
            if pa.fractionComplete > 0.33 {
                pa.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                pa.isReversed = true
                pa.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
        default:
            break
        }
    }

}
