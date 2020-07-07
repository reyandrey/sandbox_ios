//
//  AppCoordinator.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//
import UIKit

final class AppCoordinator: BaseCoordinator {
  private var window: UIWindow
  private var navigationController: UINavigationController!
  
  init(with window: UIWindow) {
    self.window = window
    navigationController = UINavigationController()
    super.init()
  }
  
  override func start() {
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    setAppearance()
    
    showMain()
  }
}

private extension AppCoordinator {
  
  func showMain() {
    let mainCoordinator = MainCoordinator(with: navigationController)
    mainCoordinator.completionHandler? = { [weak self] in
      self?.removeChild(mainCoordinator)
    }
    mainCoordinator.start()
  }
  
  func setAppearance() {
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.barStyle = .blackTranslucent
    navBarAppearance.tintColor = .lightGray
    navBarAppearance.isTranslucent = true
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
  }
}
