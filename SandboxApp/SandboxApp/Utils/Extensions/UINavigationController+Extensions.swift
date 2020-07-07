//
//  UINavigationController+Extensions.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// A convenience method adding completion handling to `pushViewController`
    public func pushViewController(_ viewController: UIViewController,
                                   animated: Bool,
                                   completion: (() -> ())?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    /// A convenience method adding completion handling to `popViewController`
    public func popViewController(animated: Bool,
                                  completion: (()->())?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
}
