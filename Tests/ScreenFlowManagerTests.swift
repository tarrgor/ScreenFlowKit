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
    let manager = FlowManager.shared
    let flow = Flow(name: "TestFlow")
  
    manager.register(flow: flow)
  
    XCTAssertNotNil(manager["TestFlow"])
  }
  
  func testScreenFlowManager_WindowIsSetByGuess() {
    XCTAssertNotNil(FlowManager.shared.window)
  }
  
  func testScreenFlowManager_WindowIsSetManually() {
    let window = UIWindow()
    FlowManager.shared.window = window
    XCTAssert(FlowManager.shared.window == window)
  }
  
  func testStartAFlow_FirstScreenShouldDisplay() {
    let manager = FlowManager.shared
    let flow = Flow(name: "TestFlow")
      .add(element: ScreenFromCode<UIViewController>(screenId: "Start"), initialScreen: true)
      .add(element: ScreenFromCode<UIViewController>(screenId: "Second"))
    
    manager.register(flow: flow)
    manager.start(flow: "TestFlow")
    
    XCTAssertNotNil(manager.window.rootViewController)
    XCTAssert(manager.window.rootViewController is UINavigationController)
    
    let navController = manager.window.rootViewController as! UINavigationController
    XCTAssertNotNil(navController.visibleViewController)
  }
}



