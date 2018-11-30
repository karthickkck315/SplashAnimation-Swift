
//
//  SecondViewController.swift
//  SplashAnimation-Swift
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class SecondViewController: UICircularViewController {

  override func loadView() {
    super.loadView()
    launchGradient()
    let imaView = UIImageView.init(frame: CGRect(x: self.view.frame.width/2 - 80, y: self.view.frame.height/2 - 80, width: 160, height: 160))
    imaView.image = #imageLiteral(resourceName: "itunes")
    view.addSubview(imaView)
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
    func launchGradient(){
        let colours =  [UIColor.lightGray, UIColor.darkGray]
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.startPoint = CGPoint(x:0.5, y:0.0)
        gradient.endPoint = CGPoint(x:0.5, y:1.0)
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = [0.2, 1.0]
        self.view.layer.insertSublayer(gradient, at: 0)
    }

}
