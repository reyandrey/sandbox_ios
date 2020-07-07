//
//  NavigationController.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import PanModal

class NavigationController: UINavigationController, PanModalPresentable {
    public var panScrollable: UIScrollView? {
      return (topViewController as? PanModalPresentable)?.panScrollable
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
      let vc = super.popViewController(animated: animated)
      panModalSetNeedsLayoutUpdate()
      return vc
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      super.pushViewController(viewController, animated: animated)
      panModalSetNeedsLayoutUpdate()
    }
}
