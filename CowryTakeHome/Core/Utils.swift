//
//  Utils.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

struct Utils {
    static func plistGet<T>(key: String) -> T? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: Any] else { return nil }
        return plist[key] as? T
    }
    
    static func parseJSONFile<T: Decodable>(named fileName: String, type: T.Type) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("Error: JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
