//
//  ExploreGitHubFlowCoordinator.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import UIKit

protocol AnyExploreGitHubRouter: class {
  func openDetailScreen()
  func closeDetailScreen()
}

class ExploreGitHubFlowCoordinator: FlowCoordinator<UINavigationController, AnyExploreFlowContext> {
  // MARK: - Override
  override func start() {
    let viewModel = ExploreGitHubViewModel(context: context, router: self)
    let exploreViewController = ExploreGitHubViewController()
    let displayCollection = ExploreGitHubDisplayCollection(viewModel)
    if exploreViewController.viewModel == nil {
      exploreViewController.viewModel = viewModel
    }
    if exploreViewController.displayCollection == nil {
      exploreViewController.displayCollection = displayCollection
    }
    self.rootController.pushViewController(exploreViewController, animated: false)
    exploreViewController.navigationItem.hidesBackButton = true
  }
}

extension ExploreGitHubFlowCoordinator: AnyExploreGitHubRouter {
  func openDetailScreen() {
    let detailViewController = GitHubUserDetailViewController()
    let viewModel = GitHubUserDetailViewModel(context: context, router: self)
    detailViewController.viewModel = viewModel
    detailViewController.navigationItem.hidesBackButton = false
    rootController.pushViewController(detailViewController, animated: true)
  }
  func closeDetailScreen() {
    rootController.popViewController(animated: true)
  }
}
