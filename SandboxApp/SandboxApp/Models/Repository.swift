//
//  Repository.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import SwiftyJSON

class Repository: DataInstantiable {
  let author: String
  let name: String
  let avatar: URL
  let url: URL
  let description: String
  let language: String
  let languageColor: String
  let stars: Int
  let forks: Int
  let currentPeriodStars: Int
  
  required init(with data: Data) throws {
    let json = try JSON(data: data)
    author = json["author"].stringValue
    name = json["name"].stringValue
    avatar = URL(string: json["avatar"].stringValue) ?? URL(string: "")!
    url = URL(string: json["url"].stringValue) ?? URL(string: "")!
    description = json["description"].stringValue
    language = json["language"].stringValue
    languageColor = json["languageColor"].stringValue
    stars = json["stars"].intValue
    forks = json["forks"].intValue
    currentPeriodStars = json["currentPeriodStars"].intValue
  }
  
}
