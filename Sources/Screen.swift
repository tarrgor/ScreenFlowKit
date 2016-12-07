//
//  Screen.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit

public protocol Screen {
  var screenId: String { get }
    
  func load() -> UIViewController
}

public struct ScreenFromCode<T: UIViewController>: Screen {
  public let screenId: String
  
  public init(screenId: String) {
    self.screenId = screenId
  }
  
  public func load() -> UIViewController {
    return T()
  }
}

public struct ScreenFromStoryboard<T: UIViewController>: Screen {
  public let screenId: String
  public let storyboard: String
  public let identifier: String
  
  public init(screenId: String, storyboard: String, identifier: String) {
    self.screenId = screenId
    self.storyboard = storyboard
    self.identifier = identifier
  }

  public func load() -> UIViewController {
    let sb = UIStoryboard(name: self.storyboard, bundle: nil)
    return sb.instantiateViewController(withIdentifier: self.identifier) as! T
  }
}

