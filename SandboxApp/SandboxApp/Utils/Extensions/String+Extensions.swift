//
//  Error+Extensions.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  var digits: String {
    return components(separatedBy: CharacterSet.decimalDigits.inverted)
      .joined()
  }
}

extension String: Error {
  var localizedDescription: String { return self }
}

extension String: DataConvertible {
  public func getData() throws -> Data {
    guard let data = self.data(using: .utf8) else { throw "Failed to convert String to Data using UTF-8 encoding" }
    return data
  }
}

extension String: DataInstantiable {
  
  public init(with data: Data) throws {
    guard let string = String(data: data, encoding: .utf8) else { throw "Failed to init a UTF-8 string from data" }
    self = string
  }
  
}
