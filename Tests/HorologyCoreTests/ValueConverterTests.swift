//
//  ValueConverterTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class ValueConverterTests: XCTestCase {
    func testConvertToYears() {
        let result = ValueConverter(value: 5, valueType: .years)
            .convert(to: .months)

        XCTAssertEqual(result.value, 60)
        XCTAssertEqual(result.approximate, false)
    }

    func testConvertToMonths() {
        let result = ValueConverter(value: 2, valueType: .months)
            .convert(to: .days)

        XCTAssertEqual(result.value, 60)
        XCTAssertEqual(result.approximate, true)
    }
}
