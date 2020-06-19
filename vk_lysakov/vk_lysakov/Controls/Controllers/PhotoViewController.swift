import UIKit

class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {

    var user: User? {
        didSet {
            if let u = user {
                print(u.fullName)
                u.fotos.forEach{
                    images.append(UIImage(named: $0.name)!)
                }
            }
        }
    }
    
    @IBOutlet weak var likeButton: UILikeButton!
    @IBOutlet weak var shareButton: UIShareButton!
    @IBOutlet weak var stackView: UIStackView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        guard index >= 0 && index < images.count && images.count != 0 else { return }
        imageView.image = images[index]
        if let u = user {
            likeButton.countLike = u.fotos[index].likeCount
            likeButton.likeStatus = u.fotos[index].isLiked
        }
        panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        panGR.delegate = self
        panGR.maximumNumberOfTouches = 2
        downSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        downSwipeGR.delegate = self
        downSwipeGR.direction = .down
        view.addGestureRecognizer(panGR)
        view.addGestureRecognizer(downSwipeGR)
    }

    @IBAction func likeButtonPressed(_ sender: Any) {
        if let u = user {
            u.fotos[index].isLiked = !u.fotos[index].isLiked
            u.fotos[index].likeCount += u.fotos[index].isLiked ? 1 : -1
            likeButton.countLike = u.fotos[index].likeCount
            likeButton.likeStatus = u.fotos[index].isLiked
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("shared pressed")
        guard index >= 0 && index < images.count && images.count != 0 else { return }
        shareButton.sharedImage = images[index]
        shareButton.buttonPressed(sender)
    }
    
    private func configureUI() {
        //imageView
        self.view.insertSubview(imageView, belowSubview: stackView)
        NSLayoutConstraint .activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        ])

        self.view.insertSubview(imageView2, belowSubview: imageView)
        NSLayoutConstraint.activate([
            imageView2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageView2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView2.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageView2.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
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
    
}
