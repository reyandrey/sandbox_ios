//
//  ViewModel.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype ErrorType
    
    var onError: ((ErrorType) -> ())? { get set}
    var onUpdating: ((Bool) -> ())? { get set }
    
    func reloadData()
}
