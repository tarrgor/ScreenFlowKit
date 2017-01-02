//
//  ScreenOneViewController.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit
import ScreenFlowKit

class ScreenOneViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    FlowManager.shared.printDebugInfo()
  }

}
