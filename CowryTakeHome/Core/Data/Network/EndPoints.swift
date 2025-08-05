//
//  EndPoints.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

public enum EndPoints: String {
    private var baseURL: String { return "http://data.fixer.io/" }
    
    case latest = "api/latest?access_key={access_key}&symbols={symbols}&base={base}"
    case symbols = "symbols?access_key={access_key}"
    
    
    public var absoluteString: String {
        return baseURL+self.rawValue.param(key: "{access_key}", with: accessToken)
    }
    
    public var url: URL {
        guard let url = URL.init(string: absoluteString) else {
            preconditionFailure("The url used in \(EndPoints.self) is not valid")
        }
        
        return url
    }
    
    private var accessToken: String {
        let value: String? = Utils.plistGet(key: "fixer_access_key")
        return value ?? ""
    }
}

extension String {
    func param(key: String, with value: String) -> String {
        let value = value.replacingOccurrences(of: " ", with: "%20")
        return self.replacingOccurrences(of: key, with: value)
    }
    
    var url: URL? {
        return URL(string: self)
    }
}
