//
//  ScreenFlow.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import Foundation

public enum ScreenFlowError: Error {
  case startScreenNotInFlow
  case noStartScreenDefined
  case noNavigationControllerInScreenFlowManager
}

public class ScreenFlow {
  public let name: String
  
  fileprivate var _elements: [String:ScreenFlowElement] = [:]
  fileprivate var _startElementName: String?
  
  public init(name: String) {
    self.name = name
  }
  
  public func add(element: ScreenFlowElement, initialScreen: Bool = false) -> ScreenFlow {
    self._elements[element.name] = element
    if (initialScreen) {
      self._startElementName = element.name
    }
    return self
  }
  
  public subscript(name: String) -> ScreenFlowElement? {
    get {
      return self._elements[name]
    }
  }
  
  func run() throws {
    guard let startElementName = _startElementName else {
      throw ScreenFlowError.noStartScreenDefined
    }
    guard let element = _elements[startElementName] else {
      throw ScreenFlowError.startScreenNotInFlow
    }
    guard let navController = ScreenFlowManager.shared.navigationController else {
      throw ScreenFlowError.noNavigationControllerInScreenFlowManager
    }
    let vc = element.load()
    navController.setViewControllers([vc], animated: false)
  }
}
