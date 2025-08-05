//
//  HomeViewModelTests.swift
//  CowryTakeHome
//
//  Created by Moses A. on 05/08/2025.
//
@testable import CowryTakeHome
import XCTest

class HomeViewModelTests: XCTestCase {
    
    var sut: DefaultHomeViewModel!
    var mockFetchRate: MockFetchRateUsecase!
    
    override func setUp() {
        super.setUp()
        mockFetchRate = MockFetchRateUsecase()
        sut = DefaultHomeViewModel(
            saveConversionUsecase: MockSaveConversion(),
            fetchConversionHistoryUsecase: MockFetchConversionHistory(),
            fetchRateUsecase: mockFetchRate,
            fetchSymbols: MockFetchSymbolsUsecase()
        )
    }
    
    func testConvertWithValidSymbols() {
        // Given
        let testRate = Rate(id: 1, base: "USD", name: "EUR", value: 0.85)
        let expectation = self.expectation(description: "Rate fetched")
        var rateReceived: Rate?
        
        sut.errorHandler = { message in
            XCTFail("Unexpected error: \(message)")
        }
        
        // When
        sut.convert(base: "USD", against: "EUR")
        
        // Then - Verify immediate effects
        XCTAssertEqual(mockFetchRate.basePassed, "USD")
        XCTAssertEqual(mockFetchRate.againstPassed, "EUR")
        XCTAssertEqual(mockFetchRate.executeCallCount, 1)
        
        // Configure mock to respond
        mockFetchRate.triggerSuccess(with: testRate)
        
        // Verify async effects
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            rateReceived = self.sut.rate
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0) // More generous timeout
        
        // Final assertions
        XCTAssertEqual(rateReceived?.base, "USD")
        XCTAssertEqual(rateReceived?.name, "EUR")
        XCTAssertEqual(rateReceived?.value ?? 0.00, 0.85, accuracy: 0.001)
    }
}
