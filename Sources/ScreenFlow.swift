//
//  ScreenFlow.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import Foundation

public class ScreenFlow {
  public let name: String
  
  fileprivate var _elements: [String:ScreenFlowElement] = [:]
  
  public init(name: String) {
    self.name = name
  }
  
  public func add(element: ScreenFlowElement) -> ScreenFlow {
    self._elements[element.name] = element
    return self
  }
  
  public subscript(name: String) -> ScreenFlowElement? {
    get {
      return self._elements[name]
    }
  }
}
