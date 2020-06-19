import UIKit

class AnimatorDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    
    let endFrame: CGRect
    
    init(_ endFrame: CGRect) {
        self.endFrame = endFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.3 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let vcFrom = transitionContext.viewController(forKey: .from), let snapshot = vcFrom.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        let vContainer = transitionContext.containerView
        vContainer.addSubview(snapshot)
        vcFrom.view.isHidden = true
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        snapshot.alpha = 1
                        snapshot.frame = self.endFrame },
                       completion: { success in
                        snapshot.alpha = 1
                        snapshot.removeFromSuperview()
                        transitionContext.completeTransition(true) })
    }
}
