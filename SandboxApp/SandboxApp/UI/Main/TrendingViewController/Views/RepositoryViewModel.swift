//
//  ItemViewModel.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class RepositoryViewModel {
  var model: Repository
  var cellIndexPath: IndexPath?
  
  init(repo: Repository) {
    self.model = repo
  }
}

extension RepositoryViewModel {
  var title: String {
    return "\(model.author)/\(model.name)"
  }
  
  var description: String {
    return "\(model.description)"
  }
  
  var language: String {
    return model.language
  }
  
  var languageColor: UIColor {
    return UIColor(hex: model.languageColor) ?? UIColor.clear
  }
  
  var starsTotal: String {
    return "\(model.stars.kFormatted())"
  }
  
  var starsNew: String {
    return "+\(model.currentPeriodStars.kFormatted())"
  }
}

extension RepositoryViewModel: CellRepresentable {
  
  static func registerCell(tableView: UITableView) {
    tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.reuseId)
  }
  
  func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.reuseId, for: indexPath) as? RepositoryCell else { fatalError() }
    cell.indexPath = indexPath
    cellIndexPath = indexPath
    cell.set(self)
    return cell
  }
  
}
