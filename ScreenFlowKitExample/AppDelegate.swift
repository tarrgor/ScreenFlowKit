//
//  AppDelegate.swift
//  ScreenFlowKitExample
//
//  Created by Thorsten Klusemann on 04.12.16.
//
//

import UIKit
import ScreenFlowKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    initScreenFlow()
    return true
  }

  fileprivate func initScreenFlow() {
    setupScreenFlow(for: self.window!)
    let flow = ScreenFlow(name: "TestFlow")
      .add(element: Screen<StartViewController>(name: "Start"))
      .add(element: Screen<ScreenOneViewController>(name: "Screen1"))
      .add(element: Screen<ScreenTwoViewController>(name: "Screen2"))
    ScreenFlowManager.shared.register(flow: flow)
  }

}

