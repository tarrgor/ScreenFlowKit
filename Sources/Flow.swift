//
//  ScreenFlow.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import Foundation

public enum FlowError: Error {
  case startScreenNotInFlow
  case noStartScreenDefined
  case noNavigationControllerInScreenFlowManager
}

public class Flow {
  public let name: String
  
  fileprivate var _elements: [String:Screen] = [:]
  fileprivate var _startElementName: String?
  
  public init(name: String) {
    self.name = name
  }
  
  public func add(element: Screen, initialScreen: Bool = false) -> Flow {
    self._elements[element.screenId] = element
    if (initialScreen) {
      self._startElementName = element.screenId
    }
    return self
  }
  
  public subscript(name: String) -> Screen? {
    get {
      return self._elements[name]
    }
  }
  
  func run() throws {
    guard let startElementName = _startElementName else {
      throw FlowError.noStartScreenDefined
    }
    guard let element = _elements[startElementName] else {
      throw FlowError.startScreenNotInFlow
    }
    guard let navController = FlowManager.shared.navigationController else {
      throw FlowError.noNavigationControllerInScreenFlowManager
    }
    let vc = element.load()
    navController.setViewControllers([vc], animated: false)
  }
}
