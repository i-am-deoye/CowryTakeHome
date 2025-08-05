//
//  ILocalCRUD.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

protocol ILocalCRUD {
    associatedtype T
    
    func save(_ entity: T)
    func fetch() -> [T]
}
