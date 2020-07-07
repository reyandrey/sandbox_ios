//
//  CellRepresentable.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

protocol CellRepresentable {
  var cellIndexPath: IndexPath? { get set }
  static func registerCell(tableView: UITableView)
  func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
