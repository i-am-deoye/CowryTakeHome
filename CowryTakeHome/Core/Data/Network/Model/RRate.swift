//
//  RRate.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation
import SwiftyJSON

struct RRate: InitMappable, ToMappable {
    typealias T = Rate
    
    var base: String = ""
    let name: String?
    let value: Double?
    
    init(json: JSON) {
        self.name = json.keys.first
        self.value = (json.values.first as? SwiftyJSON.JSON)?.doubleValue
    }
    
    
    func to() -> Rate {
        return Rate.init(id: nil, base: base, name: name ?? "", value: value ?? 0.00)
    }
}
