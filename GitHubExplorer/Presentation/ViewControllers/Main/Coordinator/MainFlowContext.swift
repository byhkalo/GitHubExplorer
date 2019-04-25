//
//  MainFlowContext.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

enum MainFlowChange: AnyContextChange {
  /// Cases
  case none
  /// Init
  init() { self = .none }
}

protocol AnyMainFlowContext: AnyObservableContext {
  // It's MainFlowContext Interfase
  var exploreContext: AnyExploreFlowContext { get }
}

class MainFlowContext: ObservableContext<MainFlowChange> {
  // Paste Storage Properties
  var exploreContext: AnyExploreFlowContext = ExploreGitHubFlowContext()
}

extension MainFlowContext: AnyMainFlowContext {
  // Implement AnyMainFlowContext methods
}
