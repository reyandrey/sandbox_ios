//
//  UIStoryboard+Extensions.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiable {
    init(storyboard name: String, withStoryboardID storyboardID: String?) throws
    static var storyboardID: String { get }
}

public extension StoryboardInstantiable where Self: UIViewController {
    static var storyboardID: String {
        return String(describing: Self.self)
    }
    
    init(storyboard name: String, withStoryboardID storyboardID: String? = Self.storyboardID) throws {
      let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
      guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardID ?? Self.storyboardID) as? Self
        else { throw "Failed to load \(String(describing: Self.self)) from storyboard: \(name)" }
      self = vc
    }
}
