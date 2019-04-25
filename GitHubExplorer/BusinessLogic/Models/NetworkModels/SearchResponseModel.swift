//
//  SearchResponseModel.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

struct SearchResponseModel: Codable {
  // MARK: - Properties
  //swiftlint:disable identifier_name
  let total_count: Int
  let incomplete_results: Bool
  let items: [SearchItemModel]
}
