//
//  Rate.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

public struct Rate {
    let id: Int?
    let base: String
    let name: String
    let value: Double
    
    public init(id: Int?, base: String, name: String, value: Double) {
        self.id = id
        self.base = base
        self.name = name
        self.value = value
    }
}
