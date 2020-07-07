//
//  Bundle+Extensions.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//
import Foundation

public extension Bundle {
  
  //MARK: Info dictionary
  
  static func infoDictionaryValue<T>(key: String) -> T? {
    return Bundle.main.infoDictionary?[key] as? T
  }
  
}
