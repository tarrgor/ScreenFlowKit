//
// Created by Thorsten Klusemann on 05.01.17.
//

import Foundation

struct Stack<Element: Hashable> {

  fileprivate var _elements: [Element] = []

  /// Pushes the specified element on top of the stack
  mutating func push(element: Element) {
    _elements.append(element)
  }

  /// Removes the top element from the stack and returns it. If the stack is empty
  /// it will return nil.
  mutating func pop() -> Element? {
    return _elements.count > 0 ? _elements.removeLast() : nil
  }

}

extension Stack: Sequence {

  typealias Iterator = AnyIterator<Element>

  func makeIterator() -> Iterator {
    var iterator = _elements.reversed().makeIterator()
    return AnyIterator {
      return iterator.next()
    }
  }

}

extension Stack: Collection {

  typealias Index = Int

  var startIndex: Index {
    return _elements.reversed().startIndex
  }
  var endIndex: Index {
    return _elements.reversed().endIndex
  }

  func index(after i: Index) -> Index {
    return i + 1
  }

  subscript(position: Index) -> Iterator.Element {
    precondition(indices.contains(position), "Index out of bounds")
    return _elements[position]
  }

}

extension Stack: ExpressibleByArrayLiteral {

  init(arrayLiteral elements: Element...) {
    self.init()
    for element in elements {
      push(element: element)
    }
  }

}