//
//  GitHubTrendingAPI.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

enum GitHubTrendingAPI {
  case trendingRepositories(language: String, since: String)
  case trendingDevelopers(language: String, since: String)
  case languages
}

extension GitHubTrendingAPI {
  var baseURL: URL {
      return URL(string: "https://ghapi.huchen.dev")!
  }

  var path: String {
      switch self {
      case .trendingRepositories: return "/repositories"
      case .trendingDevelopers: return "/developers"
      case .languages: return "/languages"
      }
  }
  
  var headers: [String: String]? {
      return nil
  }
  
  var parameters: [String: Any]? {
      var params: [String: Any] = [:]
      switch self {
      case .trendingRepositories(let language, let since),
           .trendingDevelopers(let language, let since):
          params["language"] = language
          params["since"] = since
      default: break
      }
      return params
  }
}

