//
//  TableViewCell.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
// bg 040810hex
class RepositoryCell: UITableViewCell, CellIdentifiable {
  var indexPath: IndexPath?
  
  @IBOutlet private weak var avatarImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var starsTotalLabel: UILabel!
  @IBOutlet private weak var starsSinceLabel: UILabel!
  @IBOutlet private weak var languageLabel: UILabel!
  @IBOutlet private weak var languageView: UIView!
  
  func set(_ viewModel: RepositoryViewModel) {
    guard indexPath == viewModel.cellIndexPath else { print("\(Self.reuseId): cell indexPath != viewModel.cellIndexPath"); return }
    nameLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    starsTotalLabel.text = viewModel.starsTotal
    starsSinceLabel.text = viewModel.starsNew
    languageLabel.text = viewModel.language
    languageView.backgroundColor = viewModel.languageColor
  }
  
}
