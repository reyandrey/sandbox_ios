//
//  TableViewModel.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

final class TableViewModel: ViewModel {
  typealias ErrorType = String
  
  var onError: ((String) -> ())?
  var onUpdating: ((Bool) -> ())?
  var onSelect: ((Repository) -> ())?
  
  var items: [CellRepresentable] = []
  
  func reloadData() {
    onUpdating?(true)
    GitHubTrendingService.getTrendingRepositories(language: "swift") { data, error in
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
