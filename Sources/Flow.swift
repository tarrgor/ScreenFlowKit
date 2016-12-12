//
//  ScreenFlow.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import Foundation

public enum FlowError: Error {
  case noStartScreenDefined
}

public class Flow {
  public let name: String
  
  fileprivate var _screens: [String:Screen] = [:]
  fileprivate var _startScreen: Screen? = nil
  fileprivate var _currentScreen: Screen? = nil
  
  public init(name: String) {
    self.name = name
  }
  
  public func add(screen: Screen, initial: Bool = false) -> Flow {
    self._screens[screen.screenId] = screen
    if (_startScreen == nil || initial) {
      self._startScreen = screen
    }
    return self
  }
  
  public subscript(name: String) -> Screen? {
    get {
      return self._screens[name]
    }
  }
  
  func run() throws {
    guard let startScreen = _startScreen else {
      throw FlowError.noStartScreenDefined
    }
    startScreen.show()
    self._currentScreen = startScreen
  }
}
