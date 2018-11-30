

import UIKit
import QuartzCore
import CoreGraphics

public extension UIView {
  
  func drawAnimatedCircularMask(
    startFrame: CGRect,
    duration: TimeInterval,
    revealType: RevealType,
    _ completeBlock: (() -> ())? = nil) {

    let maskLayer = CAShapeLayer()
    let radius = sqrt(pow(frame.size.width, 2) + pow(frame.size.height, 2)) * 2

    let originRect: CGRect
    let newRect: CGRect
    let timingFunction: String

    switch revealType {
      case RevealType.reveal:
        originRect = startFrame
        newRect = CGRect(
          origin: CGPoint(
            x: frame.size.width/2-radius/2,
            y: frame.size.height/2-radius/2),
          size: CGSize(
            width: radius,
            height: radius))
        timingFunction = CAMediaTimingFunctionName.easeIn.rawValue
        break
      case RevealType.unreveal:
        originRect = CGRect(
          origin: CGPoint(
            x: frame.size.width/2-radius/2,
            y: frame.size.height/2-radius/2),
          size: CGSize(
            width: radius,
            height: radius))
        newRect = startFrame
        timingFunction = CAMediaTimingFunctionName.easeOut.rawValue
        break
    }

    let originPath = CGPath(ellipseIn: originRect, transform: nil)
    maskLayer.path = originPath

    let oldPath = maskLayer.path
    let newPath = CGPath(ellipseIn: newRect, transform: nil)

    layer.mask = maskLayer

    let revealAnimation = CABasicAnimation(keyPath: ANIMATION_KEY_PATH)
    revealAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: timingFunction))
    revealAnimation.fromValue = oldPath
    revealAnimation.toValue = newPath
    revealAnimation.duration = duration
    
    maskLayer.path = newPath

    LayerAnimator(layer: maskLayer, animation: revealAnimation)
      .startAnimationWithBlock { () -> Void in
        completeBlock?()
      }

  }

}
