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
    //navBarAppearance.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    //navBarAppearance.shadowImage = UIImage()
    //navBarAppearance.backgroundColor = UIColor(hex: "#040810")
    navBarAppearance.barStyle = .blackTranslucent
    navBarAppearance.barTintColor = UIColor(hex: "#040810")
    navBarAppearance.isTranslucent = false
    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
  }
}
