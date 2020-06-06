import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let src = transitionContext.viewController(forKey: .from),
            let dst = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(dst.view)
        
        src.view.frame = transitionContext.containerView.frame
        dst.view.frame = transitionContext.containerView.frame
        
        dst.view.transform = CGAffineTransform(translationX: dst.view.frame.width,y: -dst.view.frame.width)
            .rotated(by: -90)
            .translatedBy(x: -dst.view.frame.width,y: dst.view.frame.width)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75, animations: {
                let t = CGAffineTransform(translationX: -src.view.frame.width, y: -src.view.frame.width)
                src.view.transform = t.rotated(by: 90).translatedBy(x: src.view.frame.width, y: src.view.frame.width)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                dst.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                src.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
