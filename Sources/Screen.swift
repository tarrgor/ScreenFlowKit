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
}

public struct Screen<T: UIViewController>: ScreenFlowElement {
  
  public let name: String
  
  public init(name: String) {
    self.name = name
  }
  
}

