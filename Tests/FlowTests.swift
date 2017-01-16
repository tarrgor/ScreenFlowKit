//
// Created by Thorsten Klusemann on 16.01.17.
//

import Foundation
import XCTest
@testable import ScreenFlowKit

class FlowTests: XCTestCase {

  var manager: FlowManager!
  var flow: Flow!
  var screen1: Screen!
  var screen2: Screen!

  override func setUp() {
    super.setUp()

    manager = FlowManager.shared
    screen1 = ScreenFromCode<Mock1ViewController>(screenId: "Screen1")
        .exit(name: "success", to: .screen(screenId: "Screen2"))
    screen2 = ScreenFromCode<Mock2ViewController>(screenId: "Screen2")
    flow = Flow(name: "TestFlow")
        .add(screen: screen1, initial: true)
        .add(screen: screen2)

    manager.register(flow: flow)
    manager.start(flow: "TestFlow")
  }

  func testGoBack_WithEmptyStack_ShouldReturnFalse() {
    XCTAssertFalse(flow.goBack())
  }

  func testGoBack_AfterPushTransition_ShouldReturnTrueAndScreen1IsVisible() {
    try! flow.proceed(with: "success")
    XCTAssertTrue(flow.goBack())

    let scr1: ScreenFromCode<Mock1ViewController> = screen1 as! ScreenFromCode<Mock1ViewController>
    XCTAssertEqual(manager.navigationController?.visibleViewController, scr1._viewController)
    XCTAssertEqual(flow.currentScreen!.screenId, screen1!.screenId)
  }
}
