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

  func testStartAFlow_NoScreensDefined_ShouldHaveErrorState() {
    let manager = FlowManager.shared
    let flow = Flow(name: "TestFlow")

    manager.register(flow: flow)
    manager.start(flow: "TestFlow")

    let error = FlowError.noStartScreenDefined
    XCTAssert(flow.state == FlowState.error(error: error))
  }

  func testScreen_ExitToSecondScreen_SecondScreenShouldBeVisible() {
    let manager = FlowManager.shared
    let screen1 = ScreenFromCode<Mock1ViewController>(screenId: "Screen1")
        .exit(name: "success", to: .screen(screenId: "Screen2"))
    let screen2 = ScreenFromCode<Mock2ViewController>(screenId: "Screen2")
    let flow = Flow(name: "TestFlow")
        .add(screen: screen1, initial: true)
        .add(screen: screen2)

    manager.register(flow: flow)
    manager.start(flow: "TestFlow")

    XCTAssertNotNil(manager.window.rootViewController)
    XCTAssert(manager.window.rootViewController is UINavigationController)

    let navController = manager.window.rootViewController as! UINavigationController
    XCTAssertNotNil(navController.visibleViewController)
    XCTAssert(navController.visibleViewController is Mock1ViewController)

    let exp = expectation(description: "ViewController did appear")
    Mock2ViewController.expectation = exp
    manager.proceed(with: "success")

    waitForExpectations(timeout: 2.0)

    XCTAssertNotNil(navController.visibleViewController)
    XCTAssert(navController.visibleViewController is Mock2ViewController)
  }
}

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



