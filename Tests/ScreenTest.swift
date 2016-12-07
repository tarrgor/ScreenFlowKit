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
    let screen = ScreenFromCode<UIViewController>(screenId: "TestScreen")
    let vc = screen.load()
    
    XCTAssert(vc is UIViewController)
  }
  
}
