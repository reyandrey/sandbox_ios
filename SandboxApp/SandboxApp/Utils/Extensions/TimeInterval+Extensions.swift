//
//  TimeInterval+Extensions.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

public extension TimeInterval {
  static var animationDuration: TimeInterval = 0.33
  
  func stringHHMM() -> String {
    let time = NSInteger(self)
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    return String(format: "%0.2d:%0.2d", hours, minutes)
  }
  
  func stringHHMMSS() -> String {
    let time = NSInteger(self)
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    return  (hours == 0) ? String(format: "%0.2d:%0.2d", minutes, seconds) : String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
  }
  
  func stringMMSS() -> String {
    let time = NSInteger(self)
    let seconds = time % 60
    let minutes = time / 60
    return String(format: "%0.2d:%0.2d", minutes, seconds)
  }
}
