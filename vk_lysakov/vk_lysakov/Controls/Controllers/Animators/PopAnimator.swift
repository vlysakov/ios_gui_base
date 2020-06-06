import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let src = transitionContext.viewController(forKey: .from),
            let dst = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(dst.view)
        transitionContext.containerView.sendSubviewToBack(dst.view)
        
        src.view.frame = transitionContext.containerView.frame
        dst.view.frame = transitionContext.containerView.frame

        dst.view.transform = CGAffineTransform(translationX: -dst.view.frame.width, y: -dst.view.frame.width)
            .rotated(by: 90).translatedBy(x: dst.view.frame.width, y: dst.view.frame.width)
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.75, animations: {
                dst.view.transform = .identity
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations: {
                src.view.transform = CGAffineTransform(translationX: src.view.bounds.width,y: -src.view.bounds.width)
                .rotated(by: -90)
                .translatedBy(x: -src.view.frame.width,y: src.view.bounds.width)
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                src.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                dst.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
