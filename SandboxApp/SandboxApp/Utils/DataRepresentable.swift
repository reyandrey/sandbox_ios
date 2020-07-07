//
//  DataRepresentable.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

public typealias DataRepresentable = DataInstantiable&DataConvertible

public protocol DataInstantiable {
    init(with data: Data) throws
    var headers: [AnyHashable: Any]? { get set }
}

extension DataInstantiable {
    public var headers: [AnyHashable: Any]? {
        get {
            return nil
        }
        set {
            //do nothing
        }
    }
}

public protocol DataConvertible {
    func getData() throws -> Data
}
