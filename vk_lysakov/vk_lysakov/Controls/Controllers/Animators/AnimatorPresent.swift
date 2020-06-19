import UIKit

class AnimatorPresent: NSObject, UIViewControllerAnimatedTransitioning {
    
    let startFrame: CGRect
    
    init (_ frame: CGRect) {
        self.startFrame = frame
    }
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.3 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let vc = transitionContext.viewController(forKey: .to), let snapshot = vc.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        let container = transitionContext.containerView
        
        vc.view.isHidden = true
        container.addSubview(vc.view)
        
        snapshot.frame = self.startFrame
        container.addSubview(snapshot)
        
        UIView.animate (withDuration: 0.3,
                        animations: {
                            snapshot.alpha = 1
                            snapshot.frame = vc.view.frame},
                        completion: { success in
                            snapshot.alpha = 0
                            vc.view.isHidden = false
                            snapshot.removeFromSuperview()
                            transitionContext.completeTransition(true) })
    }
        
}
