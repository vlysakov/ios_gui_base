import UIKit

class BigPhotoViewController: UIViewController, UIViewControllerTransitioningDelegate {
    enum AnimationDirection {
        case left
        case right
    }
    
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
    
    //MARK: Initializers
    convenience init(images: [UIImage], index: Int) {
        self.init()
        self.images = images
        self.index = index
//        guard self.index >= self.images.count else { return }
        self.imageView.image = self.images[self.index]
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = .systemBackground
    }
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let leftSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(photoSwiped(_:)))
//        leftSwipeGR.direction = .left
//        let rightSwipeGR = UISwipeGestureRecognizer(target: self, action: #selector(photoSwiped(_:)))
//        rightSwipeGR.direction = .right
//
//        imageView.addGestureRecognizer(leftSwipeGR)
//        imageView.addGestureRecognizer(rightSwipeGR)
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        view.addGestureRecognizer(panGR)
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
    
    @objc private func closeButtonPressed (_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Animation methods
    @objc func photoSwiped(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        switch swipeGestureRecognizer.direction {
        case .left:
            guard index + 1 <= images.count - 1 else { return }
            imageView2.transform = CGAffineTransform(translationX: 1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
            imageView2.image = images[index + 1]
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                self.imageView.transform = CGAffineTransform(translationX: -1.5*self.imageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.imageView2.transform = .identity
            }) { _ in
                self.index += 1
                self.imageView.image = self.images[self.index]
                self.imageView.transform = .identity
                self.imageView2.image = nil
            }
        default:
            guard index >= 1 else { return }
            imageView2.transform = CGAffineTransform(translationX: -1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
            imageView2.image = images[index - 1]
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                self.imageView.transform = CGAffineTransform(translationX: 1.5*self.imageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.imageView2.transform = .identity
            }) { _ in
                self.index -= 1
                self.imageView.image = self.images[self.index]
                self.imageView.transform = .identity
                self.imageView2.image = nil
            }
        }
    }
    
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        switch panGestureRecognizer.state {
        case .began:
            print(panGestureRecognizer.translation(in: view).x)
            if panGestureRecognizer.translation(in: view).x > 0 {
                guard index >= 1 else { return }
                
                animationDirection = .right
                // начальная трансформация
                imageView2.transform = CGAffineTransform(translationX: -1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                imageView2.image = images[index - 1]
                // создаем аниматор для движения направо
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.imageView.transform = CGAffineTransform(translationX: 1.5*self.imageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.imageView2.transform = .identity
                })
                print("Right animation property animator has been created")
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .end:
                        self.index -= 1
                        self.imageView.image = self.images[self.index]
                        self.imageView.transform = .identity
                        self.imageView2.image = nil
                    case .start:
                        self.imageView2.transform = CGAffineTransform(translationX: -1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                // создаем аниматор для движения налево
                guard index + 1 <= images.count - 1 else { return }
                
                animationDirection = .left
                imageView2.image = images[index + 1]
                // начальная трансформация
                imageView2.transform = CGAffineTransform(translationX: 1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                // создаем аниматор для движения направо
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.imageView.transform = CGAffineTransform(translationX: -1.5*self.imageView.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.imageView2.transform = .identity
                })
                print("Left animation property animator has been created")
                propertyAnimator.addCompletion { position in
                    switch position {
                    case .end:
                        self.index += 1
                        self.imageView.image = self.images[self.index]
                        self.imageView.transform = .identity
                        self.imageView2.image = nil
                    case .start:
                        self.imageView2.transform = CGAffineTransform(translationX: 1.3*self.imageView2.bounds.width, y: 150).concatenating(CGAffineTransform(scaleX: 1.3, y: 1.3))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            }
        case .changed:
            guard let propertyAnimator = self.propertyAnimator else { return }
            print (String.init(format: "x = %f y = %f", panGestureRecognizer.translation(in: view).x, panGestureRecognizer.translation(in: view).y))
            switch animationDirection {
            case .right:
                let percent = min(max(0, panGestureRecognizer.translation(in: view).x / view.frame.width), 1)
                propertyAnimator.fractionComplete = percent
            case .left:
                let percent = min(max(0, -panGestureRecognizer.translation(in: view).x / view.frame.width), 1)
                propertyAnimator.fractionComplete = percent
            }
        case .ended:
            guard let propertyAnimator = self.propertyAnimator else { return }
            if propertyAnimator.fractionComplete > 0.33 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
        default:
            break
        }
    }

}