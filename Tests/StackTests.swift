//
// Created by Thorsten Klusemann on 07.01.17.
//

import Foundation
import XCTest
@testable import ScreenFlowKit

class StackTests: XCTestCase {

  var stack: Stack<String>!

  override func setUp() {
    super.setUp()

    stack = Stack<String>()
  }

  func testIsEmpty_ShouldReturnTrueIfNothingIsThere() {
    XCTAssertTrue(stack.isEmpty)
  }

  func testIsEmpty_ShouldReturnFalseAfterAPush() {
    stack.push("Something")

    XCTAssertFalse(stack.isEmpty)
  }

  func testCount_ShouldBeZeroAtStart() {
    XCTAssert(stack.count == 0)
  }

  func testCount_ShouldBeTwoAfterPushingTwoTimes() {
    stack.push("First")
    stack.push("Second")

    XCTAssert(stack.count == 2)
  }

  func testPushAndPeek_CorrectElementShouldBeOnTop() {
    stack.push("First")
    stack.push("Second")

    XCTAssert(stack.peek() == "Second")
  }

  func testPushAndPop_CorrectElementShouldBeOnTop() {
    stack.push("First")
    stack.push("Second")

    XCTAssert(stack.pop() == "Second")
    XCTAssert(stack.peek() == "First")
  }

  func testClear_StackShouldBeEmpty() {
    stack.push("First")
    stack.push("Second")
    stack.clear()

    XCTAssertTrue(stack.isEmpty)
  }
}
