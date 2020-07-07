//
//  Date+Extensions.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

public extension Date {
  
  func changeTo(component: Calendar.Component, by count: Int)  -> Date {
    return Calendar.current.date(byAdding: component, value: count, to: self)!
  }
  
  func getTimestamp() -> Int64 {
    return Int64(self.timeIntervalSince1970 * 1000)
  }
  
}
