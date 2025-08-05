//
//  DataExt.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation
import  SwiftyJSON

extension Data {

    func decode(key: String, keys: [String] = []) -> Response? {
        guard let json = try? SwiftyJSON.JSON(data: self) else { return nil }
        let success = json["success"].boolValue
        let timestamp = json["timestamp"].doubleValue
        let data = json[key].dictionaryValue
        let error = json[key].dictionaryValue
        
        var others = [String:Any?]()
        for key in keys {
            others[key] = json[key].rawValue
        }
        
        var dataError: DataError?
        if let errorCode = error["code"]?.int {
            dataError = DataError.init(code: errorCode, info: error["info"]?.string ?? ResponseError.general.localDescription )
        }
        return Response.init(success: success, timestamp: timestamp, data: data, others: others, error: dataError)
    }
}
