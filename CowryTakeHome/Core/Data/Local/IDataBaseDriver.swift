//
//  IDataBaseDriver.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

public protocol IDataBaseDriver {
    func save<T>(_ entity: T)
    func fetch<T>(_ type: T.Type) -> [T]
}
