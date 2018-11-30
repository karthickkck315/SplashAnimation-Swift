

import UIKit

public extension UINavigationController {

  func radialPresentPushViewController(
    _ viewController: UIViewController? = nil,
    _ duration: TimeInterval = DEFAULT_CIRCULAR_ANIMATION_DURATION,
    _ startFrame: CGRect = CGRect.zero,
    revealType: RevealType = .reveal,
    _ transitionCompletion: (() -> ())? = nil) {
    
    let rect: CGRect
    
    if startFrame == CGRect.zero {
      let viewControllerSize = visibleViewController?.view.frame.size
      rect = CGRect(
        origin: CGPoint(
          x: viewControllerSize?.width ?? 0,
          y: viewControllerSize?.height ?? 0),
        size: CGSize(
          width: 0,
          height: 0))
    } else {
      rect = startFrame
    }
    
    let animatorDirector = CicularTransactionDirector()
    animatorDirector.duration = duration
    delegate = animatorDirector
    animatorDirector.animationBlock = { (transactionContext, animationTime, completion) in

      let toViewController = transactionContext.viewController(
        forKey: UITransitionContextViewControllerKey.to)
      let fromViewController = transactionContext.viewController(
        forKey: UITransitionContextViewControllerKey.from)

      if let toView = toViewController?.view,
         let fromView = fromViewController?.view {

        switch revealType {
          case RevealType.reveal:
            transactionContext.containerView.insertSubview(
              toView, aboveSubview: fromView)
            toView.drawAnimatedCircularMask(
              startFrame: rect,
              duration: animationTime,
              revealType: revealType) { () -> Void in
              completion()
              transitionCompletion?()
            }
            break

          case RevealType.unreveal:
            transactionContext.containerView.insertSubview(
              toView, belowSubview: fromView)
            fromView.drawAnimatedCircularMask(
              startFrame: rect,
              duration: animationTime,
              revealType: revealType) { () -> Void in
              completion()
              transitionCompletion?()
            }
            break
        }
      }
    }

    switch revealType {
      case RevealType.reveal:
        if let viewController = viewController {
          pushViewController(viewController, animated: true)
        } else {
          print("ViewController is nil")
        }
        break
      case RevealType.unreveal:
        popViewController(animated: true)
        break
    }
  }

  func radialPresentPopViewController() {
    radialPresentPushViewController(revealType: .unreveal)
  }

}





