//
//  UserItemModel.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

struct UserItemModel: Codable {
  // MARK: - Properties
  //swiftlint:disable identifier_name
  let avatar_url: String
  let login: String
  let location: String
  let name: String
}
