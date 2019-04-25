//
//  ExploreGitHubTableCell.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import UIKit

enum ExploreGitHubTableCellAction: AnyUserAction {
  case mapAction
}

class ExploreGitHubTableCell: UITableViewCell, AnyActionView {
  // MARK: - Outlets
  @IBOutlet fileprivate(set) var avatarImageView: UIImageView!
  @IBOutlet fileprivate(set) var userNicknameLabel: UILabel!
  // MARK: - AnyActionView Properties
  weak var actionsDelegate: AnyActionViewDelegate?
  // MARK: - Actions
  @IBAction func mapButtonPressed(_ sender: UIButton) {
    actionsDelegate?.actionView(self, didAction: ExploreGitHubTableCellAction.mapAction)
  }
  
}
