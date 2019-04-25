//
//  ExploreGitHubFlowContext.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation
enum ExploreFlowChange: AnyContextChange {
  /// Cases
  case none
  /// Init
  init() { self = .none }
}

protocol AnyExploreGitHubFlowContext {
  // It's ExploreGitHubFlowContext Interfase
  var searchService: AnyGitHubSearchService { get }
  var selectedItem: SearchItemModel? { get set }
}

typealias AnyExploreFlowContext = (ObservableContext<ExploreFlowChange> & AnyExploreGitHubFlowContext)

class ExploreGitHubFlowContext: ObservableContext<ExploreFlowChange> {
  // Paste Storage Properties
  // MARK: - Properties
  let searchService: AnyGitHubSearchService = GitHubSearchService()
  var selectedItem: SearchItemModel?
}

extension ExploreGitHubFlowContext: AnyExploreGitHubFlowContext {
  // Implement AnyExploreFlowContext methods
}
