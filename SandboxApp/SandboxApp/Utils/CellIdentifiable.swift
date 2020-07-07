//
//  CellInstantiable.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

public protocol CellIdentifiable {
  
  static var reuseId: String { get }
  var indexPath: IndexPath? { get set }
  
}


public extension CellIdentifiable {
  
  static var reuseId: String {
    return String(describing: Self.self)
  }
  
}
