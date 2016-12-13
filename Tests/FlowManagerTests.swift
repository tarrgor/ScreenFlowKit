//
//  FlowManagerTests.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import XCTest
@testable import ScreenFlowKit

class FlowManagerTests: XCTestCase {
  
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
      .add(screen: ScreenFromCode<Mock1ViewController>(screenId: "Start"), initial: true)
      .add(screen: ScreenFromCode<Mock2ViewController>(screenId: "Second"))
    
    manager.register(flow: flow)
    manager.start(flow: "TestFlow")
    
    XCTAssertNotNil(manager.window.rootViewController)
    XCTAssert(manager.window.rootViewController is UINavigationController)
    
    let navController = manager.window.rootViewController as! UINavigationController
    XCTAssertNotNil(navController.visibleViewController)
    XCTAssert(navController.visibleViewController is Mock1ViewController)
  }

  func testStartAFlow_FirstScreenShouldDisplayWithoutSpecifyingInitial() {
    let manager = FlowManager.shared
    let flow = Flow(name: "TestFlow")
        .add(screen: ScreenFromCode<Mock1ViewController>(screenId: "Start"))
        .add(screen: ScreenFromCode<Mock2ViewController>(screenId: "Second"))

    manager.register(flow: flow)
    manager.start(flow: "TestFlow")

    XCTAssertNotNil(manager.window.rootViewController)
    XCTAssert(manager.window.rootViewController is UINavigationController)

    let navController = manager.window.rootViewController as! UINavigationController
    XCTAssertNotNil(navController.visibleViewController)
    XCTAssert(navController.visibleViewController is Mock1ViewController)    
  }
}

/// Mocks

class Mock1ViewController: UIViewController {
  
}

class Mock2ViewController: UIViewController {
  
}



