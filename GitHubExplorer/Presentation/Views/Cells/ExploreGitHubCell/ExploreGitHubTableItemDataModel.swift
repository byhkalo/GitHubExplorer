//
//  ExploreGitHubTableItemDataModel.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
import SDWebImage

struct ExploreGitHubTableItemDataModel {
  let title: String
  let thumbImageURL: String
}

extension ExploreGitHubTableItemDataModel: ViewDataModelType {
  func setup(on cell: ExploreGitHubTableCell) {
    cell.userNicknameLabel.text = title
    cell.avatarImageView.sd_cancelCurrentImageLoad()
    cell.avatarImageView.sd_setImage(with: URL(string: thumbImageURL),
                                     placeholderImage: nil,
                                     options: SDWebImageOptions.progressiveDownload,
                                     completed: nil)
  }
}
