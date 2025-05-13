//
//  ValueConverterTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class ValueConverterTests: XCTestCase {
    func convertToYears() {
    let result = ValueConverter(value: 13, valueType: .months)
            .convert(to: .years)

        XCTAssertEqual(result.value, 2)
        XCTAssertEqual(result.approximate, true)
    }

    func testConvertToMonths() {
        let result = ValueConverter(value: 5, valueType: .years)
            .convert(to: .months)

        XCTAssertEqual(result.value, 60)
        XCTAssertEqual(result.approximate, false)
    }

    func testConvertToDays() {
        let result = ValueConverter(value: 2, valueType: .months)
            .convert(to: .days)

        XCTAssertEqual(result.value, 62)
        XCTAssertEqual(result.approximate, true)
    }

    func convertToHours() {
        let result = ValueConverter(value: 3, valueType: .days)
            .convert(to: .hours)

        XCTAssertEqual(result.value, 72)
        XCTAssertEqual(result.approximate, false)
    }

    func convertToMinutes() {
        let result = ValueConverter(value: 7, valueType: .hours)
            .convert(to: .minutes)

        XCTAssertEqual(result.value, 420)
        XCTAssertEqual(result.approximate, false)
    }

    func convertToSeconds() {
        let result = ValueConverter(value: 3, valueType: .hours)
            .convert(to: .seconds)

        XCTAssertEqual(result.value, 10800)
        XCTAssertEqual(result.approximate, false)
    }

    func convertToDogYears() {
        let result = ValueConverter(value: 3, valueType: .years)
            .convert(to: .dogYears)

        XCTAssertEqual(result.value, 21)
        XCTAssertEqual(result.approximate, true)
    }

    func convertToCatYears() {
        let result = ValueConverter(value: 3, valueType: .years)
            .convert(to: .catYears)

        XCTAssertEqual(result.value, 24)
        XCTAssertEqual(result.approximate, true)
    }

}
