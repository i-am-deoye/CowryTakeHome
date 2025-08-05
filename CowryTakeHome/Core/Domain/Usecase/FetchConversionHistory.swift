//
//  FetchConversionHistory.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

protocol FetchConversionHistory {
    func execute() -> [Conversion]
}

final class DefaultFetchConversionHistory: FetchConversionHistory {
    private let repository: RateRepository
    
    
    init(repository: RateRepository) {
        self.repository = repository
    }
    
    func execute() -> [Conversion] {
        return repository.getHistory().map { $0.to() }
    }
}
