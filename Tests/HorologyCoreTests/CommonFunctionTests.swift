//
//  CommonFunctionTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class CommonFunctionTests: XCTestCase {
    func testHandleAdjustment() {
        let result = handleAdjustment(by: 1, on: .year, with: DateFields(year: DateTimeField(type: .year, value: 2023)))
        XCTAssertEqual(result?.year?.value, 2024)
    }

    func testHandleValue() {
        let result = handleValue(2023, on: .year, with: DateFields(year: DateTimeField(type: .year, value: 2023)))
        XCTAssertEqual(result?.year?.value, 2023)
    }
}
