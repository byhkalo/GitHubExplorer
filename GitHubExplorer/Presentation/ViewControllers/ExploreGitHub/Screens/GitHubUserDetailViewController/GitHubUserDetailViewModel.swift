//
//  GitHubUserDetailViewModel.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

enum ExploreDetailChange {
  case none
  case update
}

typealias ExploreDetailUpdateHandler = CompletionChangeHandler<ExploreDetailChange>

// MARK: - AnyExploreDetailViewModel
protocol AnyGitHubUserDetailViewModel: AnyObject {
  /// Properties
  var itemTitle: String { get }
  var itemLocation: String { get }
  var exploreDetailUpdateHandler: ExploreDetailUpdateHandler? { get set }
  /// Navigation Methods
  func closeDetailScreen()
}
// MARK: - ExploreDetailViewModel
class GitHubUserDetailViewModel {
  // MARK: - Propeties
  var itemTitle: String {
    return selectedItem.login
  }
  var itemLocation: String {
    return selectedItem.url
  }
  var exploreDetailUpdateHandler: ExploreDetailUpdateHandler?
  // MARK: - Private Properties
  fileprivate(set) var context: AnyExploreFlowContext
  fileprivate(set) weak var router: AnyExploreGitHubRouter?
  fileprivate let selectedItem: SearchItemModel
  fileprivate var selectedUserItem: UserItemModel?
  // MARK: - Init
  init(context: AnyExploreFlowContext, router: AnyExploreGitHubRouter) {
    self.context = context
    self.router = router
    self.selectedItem = context.selectedItem ??
      SearchItemModel(avatar_url: "", login: "", url: "")
    self.fetchUser()
  }
}
// MARK: - Private Help Methods
fileprivate extension GitHubUserDetailViewModel {
  func fetchUser() {
    guard selectedItem.login.isEmpty == false else { return }
    self.context.searchService
      .fetchUserDetail(login: selectedItem.login) { [weak self] userItemModel in
        guard let self = self else { return }
        self.selectedUserItem = userItemModel
        self.exploreDetailUpdateHandler?(.update)
    }
  }
}
// MARK: - Extension AnyGitHubUserDetailViewModel
extension GitHubUserDetailViewModel: AnyGitHubUserDetailViewModel {
  func closeDetailScreen() {
    router?.closeDetailScreen()
  }
}
