//
// Created by Thorsten Klusemann on 07.01.17.
//

import Foundation
import XCTest
@testable import ScreenFlowKit

class StackTests: XCTestCase {

  var stack: Stack<String>?

  override func setUp() {
    super.setUp()

    stack = [ "Green", "Red", "Black", "White" ]
  }

  func testPopElementFromStack_ReturnsCorrectElementAndReducesSizeOfStack() {

    let element = stack!.pop()

    XCTAssertNotNil(element)
    XCTAssertEqual(element!, "White")
    XCTAssertEqual(stack!.count, 3)
  }

  func testPushElementOntoStack_LastElementShouldBeEqualToPushedElementAndSizeIncreased() {

    stack!.push(element: "Blue")

    XCTAssertEqual(stack!.reversed().first!, "Blue")
    XCTAssertEqual(stack!.count, 5)

    let element = stack!.pop()

    XCTAssertEqual(element!, "Blue")
    XCTAssertEqual(stack!.count, 4)
  }

  func testPopFromEmptyStack_ShouldReturnNil() {
    stack = [ "Blue" ]

    let element = stack!.pop()
    XCTAssertEqual(element!, "Blue")
    XCTAssertEqual(stack!.count, 0)

    let expectToBeNil = stack!.pop()
    XCTAssertNil(expectToBeNil)
  }
}
