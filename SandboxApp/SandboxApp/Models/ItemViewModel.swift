//
//  ItemViewModel.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class ItemViewModel {
  var title: String
  
  var cellIndexPath: IndexPath?
  
  init(title: String) {
    self.title = title
  }
}

extension ItemViewModel: CellRepresentable {
  
  static func registerCell(tableView: UITableView) {
    tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
  }
  
  func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as? TableViewCell else { fatalError() }
    cell.indexPath = indexPath
    cellIndexPath = indexPath
    
    cell.textLabel?.text = title
    return cell
  }
  
}
