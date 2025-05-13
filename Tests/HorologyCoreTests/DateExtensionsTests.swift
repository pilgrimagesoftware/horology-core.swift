//
//  DateExtensionsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateExtensionsTests: XCTestCase {

    func testConvert() {
        let date = Date()
        let fromCalendar = Calendar(identifier: .gregorian)
        let toCalendar = Calendar(identifier: .buddhist)

        let convertedDate = date.convert(fromCalendar: fromCalendar, toCalendar: toCalendar)

        XCTAssertNotNil(convertedDate)
    }

    func testConvertWithSameCalendar() {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)

        let convertedDate = date.convert(fromCalendar: calendar, toCalendar: calendar)

        XCTAssertNotNil(convertedDate)
        XCTAssertEqual(date.timeIntervalSince1970, convertedDate.timeIntervalSince1970)
    }
}
