//
// Created by Thorsten Klusemann on 04.01.17.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    if operation == .pop {
      print("Back button pressed!")
    }

    return nil
  }

}
