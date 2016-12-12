//
//  ScreenFlowTests.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import XCTest
@testable import ScreenFlowKit

class ScreenFlowTests: XCTestCase {
  
  var flow: Flow!
  
  override func setUp() {
    super.setUp()

    self.flow = Flow(name: "TestFlow")
  }

  func testCreateScreenFlow_NameIsSetCorrectly() {
    XCTAssertEqual(flow.name, "TestFlow")
  }
  
  func testCreateScreenFlow_ScreenCanBeAccessedBySubscript() {
    _ = flow.add(screen: ScreenFromCode<UIViewController>(screenId: "TestScreen"))
    
    XCTAssertNotNil(flow["TestScreen"])
    XCTAssertEqual(flow["TestScreen"]!.screenId, "TestScreen")
  }
}
