//
//  ExploreGitHubDisplayCollection.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import UIKit

class ExploreGitHubDisplayCollection: DisplayDataCollection {
  // MARK: - Static Properties
  static var modelsForRegistration: [AnyViewDataModelType.Type] {
    return [ExploreGitHubTableItemDataModel.self]
  }
  // MARK: - Private Properties
  fileprivate let viewModel: AnyExploreGitHubCollectionViewModel
  // MARK: - Init
  init(_ viewModel: AnyExploreGitHubCollectionViewModel) {
    self.viewModel = viewModel
  }
  // MARK: DataSource
  func numberOfRows(in section: Int) -> Int {
    return viewModel.numberOfItems()
  }
  func model(for indexPath: IndexPath) -> AnyViewDataModelType {
    guard let searchItem = viewModel.item(indexPath: indexPath)
      else { return EmptyDataModel() }
    let dataItem = ExploreGitHubTableItemDataModel(
      title: searchItem.login,
      thumbImageURL: searchItem.avatar_url)
    return dataItem
  }
  func heightForRow(at indexPath: IndexPath) -> CGFloat {
    return 90.0
  }
}

// MARK: - ViewDataModelType
extension ExploreGitHubDisplayCollection: ViewDataModelType {
  func setup(on tableView: UITableView) {
    tableView.registerNibs(from: self)
  }
}
