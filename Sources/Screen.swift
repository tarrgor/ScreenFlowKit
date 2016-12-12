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

  func load()
  func unload()

  func show()
}

extension Screen {
  var navigationController: UINavigationController? {
    return FlowManager.shared.navigationController
  }
}

public class BaseScreen: Screen {
  public let screenId: String

  var _viewController: UIViewController? = nil

  fileprivate init(screenId: String) {
    self.screenId = screenId
  }

  public func load() {
    // Dummy implementation does nothing
  }

  public func unload() {
    self._viewController = nil
  }

  public func show() {
    self.load()
    if let navController = self.navigationController, let viewController = self._viewController {
      navController.setViewControllers([viewController], animated: false)
    }
  }
}

public class ScreenFromCode<T: UIViewController>: BaseScreen {
  override public init(screenId: String) {
    super.init(screenId: screenId)
  }
  
  override public func load() {
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

  override public func load() {
    let sb = UIStoryboard(name: self.storyboard, bundle: nil)
    self._viewController = sb.instantiateViewController(withIdentifier: self.identifier) as! T
  }
}

