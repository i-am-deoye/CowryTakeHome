//
//  RemoteMapper.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

protocol InitMappable {
    init(json: JSON)
}

protocol ToMappable {
    associatedtype T
    
    func to() -> T
}
