//
//  Coordinator.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

protocol Coordinator: class {
  var completionHandler: (()->())? { get set }
  
  var childCoordinators: [Coordinator] { get set }
  
  func start()
}

extension Coordinator {
  func addChild(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  
  func removeChild(_ coordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }
}

class BaseCoordinator: Coordinator {
  var completionHandler: (()->())? = nil
  
  var childCoordinators: [Coordinator] = []
  
  func start() {
    fatalError("should implement in child")
  }
}
