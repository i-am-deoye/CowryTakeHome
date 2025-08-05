//
//  CowryTakeHomeTests.swift
//  CowryTakeHomeTests
//
//  Created by Moses A. on 05/08/2025.
//

@testable import CowryTakeHome
import XCTest

// MARK: - Test Doubles

class MockSaveConversion: SaveConversion {
    var savedConversion: Conversion?
    var executeCalled = false
    
    func execute(value: Conversion) {
        executeCalled = true
        savedConversion = value
    }
}

class MockFetchConversionHistory: FetchConversionHistory {
    var conversionsToReturn: [Conversion] = []
    var executeCalled = false
    
    func execute() -> [Conversion] {
        executeCalled = true
        return conversionsToReturn
    }
}

class MockFetchRateUsecase: FetchRateUsecase {
    private(set) var basePassed: Symbol?
    private(set) var againstPassed: Symbol?
    private(set) var executeCallCount = 0
    
    // Thread-safe completion handlers
    private var successHandler: SuccessCompletion?
    private var failureHandler: FailureCompletion?
    
    func execute(base: Symbol, against: Symbol,
                success: @escaping SuccessCompletion,
                failure: @escaping FailureCompletion) {
        executeCallCount += 1
        basePassed = base
        againstPassed = against
        
        // Store for controlled triggering
        successHandler = success
        failureHandler = failure
    }
    
    // Test control methods
    func triggerSuccess(with rate: Rate) {
        DispatchQueue.main.async { [weak self] in
            self?.successHandler?(rate)
        }
    }
    
    func triggerFailure(with message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.failureHandler?(message)
        }
    }
}

class MockFetchSymbolsUsecase: FetchSymbolsUsecase {
    var successCompletion: SuccessCompletion?
    var failureCompletion: FailureCompletion?
    var executeCalled = false
    var shouldSucceed = true
    
    func execute(success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) {
        executeCalled = true
        
        if shouldSucceed {
            let symbols: [SymbolPair] = [("USD", "United States"), ("EUR", "Europe")]
            success(symbols)
        } else {
            failure("Symbols fetch failed")
        }
    }
}

// MARK: - Additional Test Doubles for ViewController Tests
class MockHomeViewModel: HomeViewModel {
    var errorHandler: ((String) -> Void)?
    var symbols: [SymbolPair] = []
    
    // Test control properties
    var getSymbolsCalled = false
    var getSymbolsClosure: (() -> Void)?
    var convertValueCalledWith: Double?
    var convertValueResult = ""
    
    func getSymbols(completion: @escaping () -> Void) {
        getSymbolsCalled = true
        getSymbolsClosure?()
        completion()
    }
    
    func convert(base: Symbol, against: Symbol) {}
    
    func convert(value: Double) -> String {
        convertValueCalledWith = value
        return convertValueResult
    }
    
    func getHistroy() -> [Conversion] { return [] }
}
