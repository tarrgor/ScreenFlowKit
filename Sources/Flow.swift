//
//  ScreenFlow.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import Foundation

public enum FlowState {
  case notRunning
  case running
  case error(error: FlowError)
}

func ==(lhs: FlowState, rhs: FlowState) -> Bool {
  switch (lhs, rhs) {
    case (.notRunning, .notRunning):
         return true
    case (.running, .running):
         return true
    case (.error(let e1), .error(let e2)) where e1 == e2:
         return true
    default:
         return false
  }
}

public enum FlowError: Error {
  case noStartScreenDefined
  case screenNotFound
  case noCurrentScreen
  case exitNotFound
}

public class Flow {
  public let name: String
  
  fileprivate var _screens: [String:Screen] = [:]
  fileprivate var _startScreen: Screen? = nil
  fileprivate var _currentScreen: Screen? = nil
  fileprivate var _state: FlowState = .notRunning
  fileprivate var _screenStack: Stack<Screen>!

  public var state: FlowState {
    return _state
  }

  public var currentScreen: Screen? {
    return self._currentScreen
  }

  public init(name: String) {
    self.name = name
    self._screenStack = Stack<Screen>()
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
      self._currentScreen = nil
      self._state = .error(error: FlowError.noStartScreenDefined)
      throw FlowError.noStartScreenDefined
    }
    startScreen.show(initial: true)
    self._currentScreen = startScreen
    self._state = .running
    self._screenStack.push(startScreen)
  }

  func proceed(with id: String) throws {
    guard let currentScreen = self._currentScreen else { throw FlowError.noCurrentScreen }
    guard let exit = currentScreen[id] else { throw FlowError.exitNotFound }

    if case let .screen(screenId) = exit {
      guard let screen = _screens[screenId] else { throw FlowError.screenNotFound }
      screen.show(initial: false)
      self._currentScreen = screen
      self._screenStack.push(screen)
    }
  }
}
