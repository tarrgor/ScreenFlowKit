//
//  Screen.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit

public enum Exit {
  case screen(screenId: String)
  case flow(name: String)
}

public protocol Screen {
  var screenId: String { get }

  func show()
  func exit(name: String, to: Exit) -> Screen
}

protocol _Screen {
  func load()
  func unload()
}

extension _Screen {
  var navigationController: UINavigationController? {
    return FlowManager.shared.navigationController
  }
}

public class BaseScreen: Screen {
  public let screenId: String
  
  fileprivate var _exits: [String:Exit] = [:]

  var _viewController: UIViewController? = nil

  fileprivate init(screenId: String) {
    self.screenId = screenId
  }

  public func show() {
    self.load()
    if let navController = self.navigationController, let viewController = self._viewController {
      navController.setViewControllers([viewController], animated: false)
    }
  }
  
  public func exit(name: String, to exit: Exit) -> Screen {
    self._exits[name] = exit
    return self
  }
}

extension BaseScreen: _Screen {
  @objc func load() { }
  
  func unload() {
    self._viewController = nil
  }
}

public class ScreenFromCode<T: UIViewController>: BaseScreen {
  override public init(screenId: String) {
    super.init(screenId: screenId)
  }
  
  override func load() {
    self._viewController = T()
  }
}

public class ScreenFromStoryboard<T: UIViewController>: BaseScreen {
  public let storyboard: String
  public let identifier: String

  public init(screenId: String, storyboard: String, identifier: String) {
    self.storyboard = storyboard
    self.identifier = identifier
    super.init(screenId: screenId)
  }

  override func load() {
    let sb = UIStoryboard(name: self.storyboard, bundle: nil)
    self._viewController = sb.instantiateViewController(withIdentifier: self.identifier) as! T
  }
}

