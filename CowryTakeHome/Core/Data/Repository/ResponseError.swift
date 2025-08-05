//
//  ResponseError.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

public enum ResponseError: Swift.Error {
    case connectivity
    case invalidData
    case general
    case otherCause(String)
    
    public var localDescription: String {
        switch self {
        case .connectivity: return "unable to connect to the server"
        case .invalidData: return "invalid data"
        case .general: return "Something went wrong with the network request, please try again later"
        case .otherCause(let string): return string
        }
    }
}
