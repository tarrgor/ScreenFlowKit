//
//  ScreenFlowManagerTests.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import XCTest
@testable import ScreenFlowKit

class ScreenFlowManagerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  func testRegisterScreenFlowWithManager_FlowIsRegistered() {
    let manager = ScreenFlowManager.shared
    let flow = ScreenFlow(name: "TestFlow")
  
    manager.register(flow: flow)
  
    XCTAssertNotNil(manager["TestFlow"])
  }
  
  func testScreenFlowManager_WindowIsSetByGuess() {
    XCTAssertNotNil(ScreenFlowManager.shared.window)
  }
  
  func testScreenFlowManager_WindowIsSetManually() {
    let window = UIWindow()
    ScreenFlowManager.shared.window = window
    XCTAssert(ScreenFlowManager.shared.window == window)
  }
  
}
