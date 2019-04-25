//
//  MainFlowCoordinator.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import UIKit

class MainFlowCoordinator: FlowCoordinator<UINavigationController, AnyMainFlowContext> {
  // MARK: - Private Properties
  fileprivate var mainViewController: MainViewController!
  fileprivate var exploreGitHubFlowCoordinator: ExploreGitHubFlowCoordinator!
  // MARK: - Public
  override func start() {
    startMainFlow()
  }
}

private extension MainFlowCoordinator {
  func startMainFlow() {
    guard let currentMainViewController = rootController.viewControllers.first as? MainViewController
      else { return }
    mainViewController = currentMainViewController
    mainViewController.model = MainViewModel()
    /// Correct place for deciding what flow should start. In this case we start only One First Flow - ExploreGitHubFlow
    startExploreGitHubFlow()
  }
  func startExploreGitHubFlow() {
    if exploreGitHubFlowCoordinator == nil {
      exploreGitHubFlowCoordinator =
        ExploreGitHubFlowCoordinator(rootController: rootController,
                                     context: context.exploreContext)
    }
    exploreGitHubFlowCoordinator.start()
  }
}
