//
//  GitHubTrendingService.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftHTTP

class GitHubTrendingService {
  
  enum PeriodType: String {
    case daily, weekly, monthly
  }
  
  static func getTrendingRepositories(language: String, since: PeriodType = .monthly, completionHandler: @escaping (([Repository]?, Error?) -> ())) {
    let target = GitHubTrendingAPI.trendingRepositories(language: language, since: since.rawValue)
    let url = target.baseURL.appendingPathComponent(target.path)
    
    HTTP.GET(url.absoluteString, parameters: target.parameters, headers: target.headers) { result in
      let repos = try? JSON(data: result.data).arrayValue.compactMap { try? Repository(with: $0.rawData()) }
      completionHandler(repos, repos == nil ? (result.error ?? "Empty response") : nil)
    }
  }
  
  
}
