//
//  Data+Extensions.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

public extension Data {
  
  var hexString: String {
    let hexString = map { String(format: "%02.2hhx", $0) }.joined()
    return hexString
  }
  
}

extension Data: DataInstantiable {
  
  public init(with data: Data) throws {
    self = data
  }
  
}

extension Data: DataConvertible {
  
  public func getData() throws -> Data {
    return self
  }
  
}
