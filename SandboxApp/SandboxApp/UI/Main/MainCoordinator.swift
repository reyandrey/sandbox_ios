//
//  MainCoordinator.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
  private var navigationController: UINavigationController!
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
    super.init()
  }
  
  override func start() {
    let vc = try! TrendingViewController(storyboard: "Main")
    vc.viewModel = TrendingViewModel()
    navigationController.setViewControllers([vc], animated: true)
  }
}

