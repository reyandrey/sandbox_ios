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
  
  var items: [CellRepresentable] = []
  
  func reloadData() {
    onUpdating?(true)
    items = (1...31).map { ItemViewModel(title: "Item #\($0)") }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.onUpdating?(false) }
  }
  
  func didSelect(at indexPath: IndexPath) {
    
  }
  
}
