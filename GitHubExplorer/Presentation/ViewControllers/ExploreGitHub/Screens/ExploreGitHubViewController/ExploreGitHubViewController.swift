//
//  ExploreGitHubViewController.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import UIKit

class ExploreGitHubViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      tableView.cellActionsDelegate = self
    }
  }
  // MARK: - Properties
  var viewModel: AnyExploreGitHubViewModel! {
    didSet {
      guard oldValue !== self.viewModel else { return }
      if let oldValue = oldValue { unsubscribe(anyViewModel: oldValue) }
      if self.viewModel != nil { subscribe() }
    }
  }
  var displayCollection: ExploreGitHubDisplayCollection!
  // MARK: - Private Properties
  // MARK: - Init
  deinit {
    self.unsubscribe(anyViewModel: viewModel)
  }
  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    displayCollection.setup(on: tableView)
    configureNavigationBar()
  }
  func configureNavigationBar() {
    navigationItem.title = "GitHub Explorer"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
  }
}
// MARK: - UITableViewDataSource
extension ExploreGitHubViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection.numberOfRows(in: section)
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection.model(for: indexPath)
    return tableView.dequeueReusableCell(for: indexPath, with: model)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return displayCollection.heightForRow(at: indexPath)
  }
}
// MARK: - UITableViewDelegate
extension ExploreGitHubViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.selectItem(at: indexPath)
  }
}
// MARK: - TableViewActionsDelegate
extension ExploreGitHubViewController: TableViewActionsDelegate {
  func tableView(_ tableView: UITableView, didAction action: AnyUserAction, onCellAt indexPath: IndexPath) {
    guard let tableCellAction = action as? ExploreGitHubTableCellAction
      else { return }
    switch tableCellAction {
    case .mapAction:
      viewModel.selectItem(at: indexPath)
    }
  }
}
// MARK: - Private Subscribe
fileprivate extension ExploreGitHubViewController {
  func unsubscribe(anyViewModel: AnyExploreGitHubViewModel) {
    anyViewModel.exploreGitHubUpdateHandler = nil
  }
  func subscribe() {
    viewModel.exploreGitHubUpdateHandler = { [weak self] change in
      guard let `self` = self else { return }
      DispatchQueue.main.async {
        switch change {
        case .update:
          self.tableView.reloadData()
        default: break
        }
      }
    }
  }
}
