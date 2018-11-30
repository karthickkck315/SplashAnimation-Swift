

import Foundation
import UIKit

public typealias AnimationBlock = (( _ transactionContext: UIViewControllerContextTransitioning,
                                     _ animationTime: TimeInterval,
                                     _ transitionCompletion: @escaping ()->()) ->())

public class CicularTransactionDirector: NSObject {

  public var duration: TimeInterval = DEFAULT_CIRCULAR_ANIMATION_DURATION
  public var transitionContext: UIViewControllerContextTransitioning?
  public var animationBlock: AnimationBlock?

}

extension CicularTransactionDirector: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
      -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    self.transitionContext = transitionContext
    self.animationBlock?(transitionContext, duration) { 
      transitionContext.completeTransition(true)
    }
  }
}

extension CicularTransactionDirector: UIViewControllerInteractiveTransitioning {

  public func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    self.transitionContext = transitionContext
    self.animationBlock?(transitionContext, duration) {  }
  }

}

extension CicularTransactionDirector: UINavigationControllerDelegate {

  public func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController)
      -> UIViewControllerAnimatedTransitioning? {
    return self
  }

  public func  navigationController(
    navigationController: UINavigationController,
    interactionControllerForAnimationController
    animationController: UIViewControllerAnimatedTransitioning)
      -> UIViewControllerInteractiveTransitioning? {
    return nil
  }

}
