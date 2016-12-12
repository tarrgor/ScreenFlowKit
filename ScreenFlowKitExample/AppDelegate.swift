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
    let flow = Flow(name: "TestFlow")
      .add(screen: ScreenFromStoryboard<StartViewController>(screenId: "Start", storyboard: "Main", identifier: "StartViewController"), initial: true)
      .add(screen: ScreenFromStoryboard<ScreenOneViewController>(screenId: "Screen1", storyboard: "Main", identifier: "ScreenOneViewController"))
      .add(screen: ScreenFromStoryboard<ScreenTwoViewController>(screenId: "Screen2", storyboard: "Main", identifier: "ScreenTwoViewController"))
    FlowManager.shared.register(flow: flow)
    FlowManager.shared.start(flow: "TestFlow")
  }

}

