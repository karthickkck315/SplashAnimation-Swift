

import Foundation
import UIKit
import QuartzCore.CALayer

class LayerAnimator: NSObject, CAAnimationDelegate {
  
  var completionBlock: (()->())?
  var animLayer: CALayer?
  var caAnimation: CAAnimation?
  
  init(layer: CALayer, animation: CAAnimation) {
    super.init()
    self.animLayer = layer
    self.caAnimation = animation
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startAnimationWithBlock(block: @escaping ()->()) {
    completionBlock = block
    if let caAnimation = self.caAnimation {
      caAnimation.delegate = self
      animLayer?.removeAllAnimations()
      animLayer?.add(caAnimation, forKey: "anim")
    }
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    animLayer?.removeAllAnimations()
    completionBlock?()
  }
  
}
