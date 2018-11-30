//
//  LaunchVC.swift

//
//  LaunchVC.swift
//  SplashAnimation-Swift
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//


import UIKit

class LaunchVC: UIViewController {
  
  
  @IBOutlet weak var titleLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
  }
  override func viewDidAppear(_ animated: Bool) {
    radialPushViewController(SecondViewController())
}
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
