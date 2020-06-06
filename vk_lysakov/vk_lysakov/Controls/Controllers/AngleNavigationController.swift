import UIKit

class AngleInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class AngleNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let transition = AngleInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        edgePanGR.edges = .left
        view.addGestureRecognizer(edgePanGR)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
    
    @objc private func leftSwipe(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            transition.hasStarted = true
            self.popViewController(animated: true)

        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                transition.hasStarted = false
                transition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))

            transition.update(progress)
            transition.shouldFinish = progress > 0.45
        case .ended:
            transition.hasStarted = false
            transition.shouldFinish ? transition.finish() : transition.cancel()
        case .cancelled:
            transition.hasStarted = false
            transition.cancel()

        default:
            break
        }
    }

}
