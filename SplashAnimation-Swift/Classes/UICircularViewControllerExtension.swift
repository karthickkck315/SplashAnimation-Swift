

import UIKit

public extension UIViewController {
  
  func radialPushViewController(
    _ viewController: UIViewController,
    _ duration: TimeInterval = DEFAULT_CIRCULAR_ANIMATION_DURATION,
    _ startFrame: CGRect = CGRect.zero,
    revealType: RevealType = .reveal,
    _ transitionCompletion: (() -> ())? = nil) {
    guard let navigationController = navigationController else {
      print("UIViewController is not a UINavigationViewController")
      return
    }
    navigationController.radialPresentPushViewController(
      viewController,
      duration,
      startFrame,
      revealType: revealType,
      transitionCompletion)
  }
  
  @objc func radialPopViewController() {
    guard let navigationController = navigationController else {
      print("UIViewController is not a UINavigationViewController")
      return
    }
    navigationController.radialPresentPopViewController()
  }
  
  func setupBackButton(
    title: String = "Back",
    style: UIBarButtonItem.Style = UIBarButtonItem.Style.plain) {
    navigationItem.hidesBackButton = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: title,
      style: style,
      target: self,
      action: #selector(radialPopViewController))
  }
  
}
