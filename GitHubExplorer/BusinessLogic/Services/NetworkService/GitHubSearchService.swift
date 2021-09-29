//
//  GitHubSearchService.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import Foundation

enum SearchLanguageType: String {
  case ruby
}

typealias SearchCompletionHandler = CompletionChangeHandler<[SearchItemModel]>
typealias UserCompletionHandler = CompletionChangeHandler<UserItemModel>
typealias DataHandler = CompletionChangeHandler<Data>

protocol AnyGitHubSearchService {
  func fetchUsers(languageType: SearchLanguageType,
                  completion: @escaping SearchCompletionHandler)
  func fetchUserDetail(login: String,
                       completion: @escaping UserCompletionHandler)
}

class GitHubSearchService {
  // MARK: Private Properties
  fileprivate var lastSearchTast: URLSessionDataTask?
}
// MARK: - AnyGitHubSearchService
extension GitHubSearchService: AnyGitHubSearchService {
  func fetchUsers(languageType: SearchLanguageType,
                  completion: @escaping SearchCompletionHandler) {
    lastSearchTast?.cancel()
    lastSearchTast = API.search(languageType).fetch { data in
      do {
        let serverResponseModel = try JSONDecoder().decode(SearchResponseModel.self, from: data)
        let searchItemModels = serverResponseModel.items
        completion(searchItemModels)
      } catch {
        completion([])
      }
    }
  }
  func fetchUserDetail(login: String, completion: @escaping UserCompletionHandler) {
    lastSearchTast?.cancel()
    lastSearchTast = API.userLogin(login).fetch { data in
      do {
        let serverUserItemModel = try JSONDecoder().decode(UserItemModel.self, from: data)
        completion(serverUserItemModel)
      } catch {
        completion(UserItemModel(avatar_url: "", login: "", location: "", name: ""))
      }
    }
  }
}

enum API {
  // GET
  case search(SearchLanguageType)
  case userLogin(String)
  // Properties
  var mainURLString: String {
    switch self {
    case .search(_):
      return "https://api.github.com/search/users"
    case .userLogin(_):
      return "https://api.github.com/users/"
    }
  }
  var requestPart: String {
    switch self {
    case let .search(mediaType):
      return "?q=followers:%3E1000+language:\(mediaType)&sort=contributions&order=desc"
    case let .userLogin(login):
      return login
    }
  }
  private var path: URL {
    return URL(string: mainURLString + requestPart)!
  }
  // Fetch Methods
  func fetch(completion: @escaping DataHandler) -> URLSessionDataTask {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: path) { data, _, error in
      guard let data = data, error == nil else { return }
      completion(data)
    }
    task.resume()
    return task
  }
}
