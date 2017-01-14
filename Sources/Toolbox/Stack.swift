//
// Created by Thorsten Klusemann on 05.01.17.
//

import Foundation

struct Stack<Element> {

  fileprivate var _elements: [Element] = []

  /// Pushes the specified element on top of the stack
  mutating func push(_ element: Element) {
    _elements.append(element)
  }

  /// Removes the top element from the stack and returns it. If the stack is empty
  /// it will return nil.
  mutating func pop() -> Element? {
    return _elements.count > 0 ? _elements.removeLast() : nil
  }

  /// Peek at the current top element without removing it from stack
  func peek() -> Element? {
    return _elements.last
  }

  /// Clears the stack completely
  mutating func clear() {
    _elements.removeAll()
  }

  /// Returns true if the stack is currently empty
  var isEmpty: Bool {
    return _elements.isEmpty
  }

  /// Returns the number of elements on the stack
  var count: Int {
    return _elements.count
  }

}
