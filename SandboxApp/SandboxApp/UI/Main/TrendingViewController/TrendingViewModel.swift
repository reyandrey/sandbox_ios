//
//  TableViewModel.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

final class TrendingViewModel: ViewModel {
  typealias ErrorType = String
  
  enum PeriodType: Int, CaseIterable {
    case daily, weekly, monthly
    
    static var titleItems: [String] {
      return Self.allCases.map { $0.title }
    }
    
    var title: String {
      return value.capitalized
    }
    
    var value: String {
      switch self {
      case .daily: return "daily"
      case .weekly: return "weekly"
      case .monthly: return "monthly"
      }
    }
  }
  
  var since: PeriodType = .weekly {
    didSet { reloadData() }
  }
  
  var onError: ((String) -> ())?
  var onUpdating: ((Bool) -> ())?
  var onSelect: ((Repository) -> ())?
  
  var items: [CellRepresentable] = []
  
  func reloadData() {
    onUpdating?(true)
    GitHubTrendingService.getTrendingRepositories(language: nil, since: self.since.value) { data, error in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        if let error = error { self.onError?(error.localizedDescription) }
        self.items = data?.map { RepositoryViewModel(repo: $0) } ?? []
        self.onUpdating?(false)
      }
    }
  }
  
  func didSelect(at indexPath: IndexPath) {
    guard let i = items[indexPath.row] as? RepositoryViewModel else { return }
    onSelect?(i.model)
  }
  
}
