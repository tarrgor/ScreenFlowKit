//
//  ScreenFlowManager.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit

public class FlowManager {
  
  public static let shared = FlowManager()
  
  fileprivate var _window: UIWindow?
  fileprivate var _navController: UINavigationController?
  fileprivate var _flows: [String:Flow] = [:]
  fileprivate var _currentFlow: Flow?

  /// The application window must be known to the ScreenFlowManager. If it is not set
  /// in code by your app, ScreenFlowManager can guess it by trying to get the first
  /// window registered with UIApplication
  public var window: UIWindow {
    get {
      if let win = self._window { return win }
      let guessedWindow = UIApplication.shared.windows.first
      assert(guessedWindow != nil, "No application window configured for ScreenFlowManager")
      self._window = guessedWindow
      return guessedWindow!
    }
    set {
      self._window = newValue
      self._navController = nil
    }
  }
  
  var navigationController: UINavigationController? {
    return self._navController
  }
  
  fileprivate init() {
  }
  
  public func register(flow: Flow) {
    self._flows[flow.name] = flow
  }
  
  public subscript(name: String) -> Flow? {
    get {
      return self._flows[name]
    }
  }
  
  public func start(flow name: String) {
    if (self._navController == nil) {
      self._navController = UINavigationController()
      self.window.rootViewController = self._navController
    }
    if let flow = self._flows[name] {
      do {
        try flow.run()
        self._currentFlow = flow
      } catch {
        self._currentFlow = nil
      }
    }
  }

  public func proceed(with exitId: String) {
    guard let flow = self._currentFlow else { return }

    do {
      try flow.proceed(with: exitId)
    } catch {
      print(error)
    }
  }

  public func printDebugInfo() {
    print("Current flow: \(self._currentFlow?.name ?? "None")")
    print("Current screen: \(self._currentFlow?.currentScreen?.screenId ?? "None")")
    print("NavController: \(self._navController?.debugDescription ?? "None")")
    print("Visible ViewController: \(self.navigationController?.visibleViewController?.debugDescription ?? "None")")
  }
}



