//
//  ExploreGitHubViewModel.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

enum ExploreGitHubChange {
  case none
  case update
  case showLoadingView
}

typealias ExploreGitHubUpdateHandler = CompletionChangeHandler<ExploreGitHubChange>

// MARK: - AnyExploreGitHubCollectionViewModel
protocol AnyExploreGitHubCollectionViewModel {
  func numberOfItems() -> Int
  func item(indexPath: IndexPath) -> SearchItemModel?
}

// MARK: - AnyExploreGitHubViewModel
protocol AnyExploreGitHubViewModel: AnyObject {
  /// Properties
  var exploreGitHubUpdateHandler: ExploreGitHubUpdateHandler? { get set }
  /// Open Detail Screen
  func selectItem(at indexPath: IndexPath)
}

class ExploreGitHubViewModel {
  // MARK: - Properties
  var exploreGitHubUpdateHandler: ExploreGitHubUpdateHandler?
  // MARK: - Private Properties
  fileprivate(set) var context: AnyExploreFlowContext
  fileprivate(set) weak var router: AnyExploreGitHubRouter?
  fileprivate var searchItemModels = [SearchItemModel]()
  // MARK: - Init
  init(context: AnyExploreFlowContext, router: AnyExploreGitHubRouter) {
    self.context = context
    self.router = router
    fetchUsers()
  }
}

// MARK: - Private Help Methods
fileprivate extension ExploreGitHubViewModel {
  func fetchUsers() {
    context.searchService.fetchUsers(languageType: .ruby) { [weak self] searchModels in
      guard let `self` = self else { return }
      self.searchItemModels = searchModels
      self.exploreGitHubUpdateHandler?(ExploreGitHubChange.update)
    }
  }
}
// MARK: - Extension AnyExploreGitHubViewModel
extension ExploreGitHubViewModel: AnyExploreGitHubViewModel {
  func selectItem(at indexPath: IndexPath) {
    context.selectedItem = item(indexPath: indexPath)
    router?.openDetailScreen()
  }
}
// MARK: - Extension AnyExploreGitHubCollectionViewModel
extension ExploreGitHubViewModel: AnyExploreGitHubCollectionViewModel {
  func numberOfItems() -> Int {
    return searchItemModels.count
  }
  func item(indexPath: IndexPath) -> SearchItemModel? {
    guard indexPath.row >= 0 && indexPath.row < searchItemModels.count
      else { return nil }
    return searchItemModels[indexPath.row]
  }
}
