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
  
  var flow: ScreenFlow!
  
  override func setUp() {
    super.setUp()

    self.flow = ScreenFlow(name: "TestFlow")
  }

  func testCreateScreenFlow_NameIsSetCorrectly() {
    XCTAssertEqual(flow.name, "TestFlow")
  }
  
  func testCreateScreenFlow_ScreenCanBeAccessedBySubscript() {
    _ = flow.add(element: Screen<UIViewController>(name: "TestScreen"))
    
    XCTAssertNotNil(flow["TestScreen"])
    XCTAssertEqual(flow["TestScreen"]!.name, "TestScreen")
  }
}
