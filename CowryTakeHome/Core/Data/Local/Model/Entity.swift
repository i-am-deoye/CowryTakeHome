//
//  Entity.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation
import RealmSwift


public class Entity : Object, Persistable {
    @objc dynamic var id: String = ""
}
