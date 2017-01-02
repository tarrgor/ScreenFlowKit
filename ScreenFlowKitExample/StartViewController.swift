//
//  ViewController.swift
//  ScreenFlowKitExample
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit
import ScreenFlowKit

class StartViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    FlowManager.shared.printDebugInfo()
  }


  @IBAction func buttonPressed(sender: UIButton) {
    FlowManager.shared.proceed(with: "success")
  }
}

