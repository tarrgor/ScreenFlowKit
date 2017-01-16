//
// Created by Thorsten Klusemann on 16.01.17.
//

import UIKit
import XCTest

/// Mocks

class Mock1ViewController: UIViewController {
  static var expectation: XCTestExpectation?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Mock1ViewController.expectation?.fulfill()
  }
}

class Mock2ViewController: UIViewController {
  static var expectation: XCTestExpectation?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Mock2ViewController.expectation?.fulfill()
  }
}
