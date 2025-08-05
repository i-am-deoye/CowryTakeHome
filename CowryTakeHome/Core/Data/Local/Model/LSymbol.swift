//
//  LSymbol.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation
import RealmSwift


class LSymbol: Entity, ToMappable {
    typealias T = SymbolPair
    
    @objc dynamic var currency: String = ""
    @objc dynamic var country: String = ""
    
    override public init() {
        super.init()
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
    
    func to() -> SymbolPair {
        return (currency, country)
    }
}
