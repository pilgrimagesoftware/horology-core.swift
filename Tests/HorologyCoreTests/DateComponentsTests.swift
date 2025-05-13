//
//  DateComponentsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateComponentsTests: XCTestCase {
    func testDateComponentsFromFields() {
        let fields = DateFields(year: 2025, month: 1, day: 1, hour: 12, minute: 30, second: 45)
        let components = DateComponents.from(fields: fields)

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 12)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }

    func testDateComponentsFromFieldsWithNilValues() {
        let fields = DateFields(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil)
        let components = DateComponents.from(fields: fields)

        XCTAssertNil(components.year)
        XCTAssertNil(components.month)
        XCTAssertNil(components.day)
        XCTAssertNil(components.hour)
        XCTAssertNil(components.minute)
        XCTAssertNil(components.second)
    }

    func testDateComponentsFromFieldsWithPartialValues() {
        let fields = DateFields(year: 2025, month: nil, day: 1, hour: nil, minute: 30, second: nil)
        let components = DateComponents.from(fields: fields)

        XCTAssertEqual(components.year, 2025)
        XCTAssertNil(components.month)
        XCTAssertEqual(components.day, 1)
        XCTAssertNil(components.hour)
        XCTAssertEqual(components.minute, 30)
        XCTAssertNil(components.second)
    }

    func testDateComponentsFromFieldsWithNegativeValues() {
        let fields = DateFields(year: -2025, month: -1, day: -1, hour: -12, minute: -30, second: -45)
        let components = DateComponents.from(fields: fields)

        XCTAssertEqual(components.year, -2025)
        XCTAssertEqual(components.month, -1)
        XCTAssertEqual(components.day, -1)
        XCTAssertEqual(components.hour, -12)
        XCTAssertEqual(components.minute, -30)
        XCTAssertEqual(components.second, -45)
    }

    func testDateComponentsFromFieldsWithZeroValues() {
        let fields = DateFields(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0)
        let components = DateComponents.from(fields: fields)

        XCTAssertEqual(components.year, 0)
        XCTAssertEqual(components.month, 0)
        XCTAssertEqual(components.day, 0)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
}
