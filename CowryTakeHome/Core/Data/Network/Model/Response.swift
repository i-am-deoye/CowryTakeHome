//
//  Response.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

struct Response {
    let success: Bool
    let timestamp: Double
    let data: JSON
    let others: [String: Any?]
    let error: DataError?
}

struct DataError {
    let code: Int?
    let info: String?
}
