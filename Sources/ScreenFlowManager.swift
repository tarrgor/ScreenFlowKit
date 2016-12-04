//
//  ScreenFlowManager.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit

public class ScreenFlowManager {
  
  public static let shared = ScreenFlowManager()
  
  fileprivate var _window: UIWindow?
  fileprivate var _flows: [String:ScreenFlow] = [:]
  
  fileprivate init() {
  }
  
  public func register(flow: ScreenFlow) {
    self._flows[flow.name] = flow
  }
  
  public subscript(name: String) -> ScreenFlow? {
    get {
      return self._flows[name]
    }
  }
}

public extension UIApplicationDelegate {
  public func setupScreenFlow(for window: UIWindow) {
    ScreenFlowManager.shared._window = window
  }
}


