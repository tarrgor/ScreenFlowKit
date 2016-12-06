//
//  Screen.swift
//  ScreenFlowKit
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit

public protocol ScreenFlowElement {
  var name: String { get }
  
  func load() -> UIViewController
}

public struct Screen<T: UIViewController>: ScreenFlowElement {
  
  public let name: String
  
  public init(name: String) {
    self.name = name
  }
  
  public func load() -> UIViewController {
    return T()
  }
  
}

