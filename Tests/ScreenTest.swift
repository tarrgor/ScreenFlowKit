//
//  ScreenTest.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 06.12.16.
//
//

import XCTest
import ScreenFlowKit

class ScreenTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  func testLoadAScreen() {
    let screen = Screen<UIViewController>(name: "TestScreen")
    let vc = screen.load()
    
    XCTAssert(vc is UIViewController)
  }
  
}
