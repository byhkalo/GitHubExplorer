//
//  AppDelegate.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  // MARK: - Propoerties
  var window: UIWindow?
  var mainCoordinator: MainFlowCoordinator!
  // MARK: - UIApplicationDelegate Methods
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    startApplicationFlow()
    return true
  }
  // MARK: - Starting Application Flow
  func startApplicationFlow() {
    if let navigationController = window?.rootViewController as? UINavigationController {
      mainCoordinator = MainFlowCoordinator(rootController: navigationController,
                                            context: MainFlowContext())
      mainCoordinator.start()
    }
  }
}
