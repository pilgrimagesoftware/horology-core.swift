//
//  DateTimeFieldTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateTimeFieldTests: XCTestCase {

    func testInitialization() {
        let field = DateTimeField(type: .year, value: 2025)
        XCTAssertEqual(field.type, .year)
        XCTAssertEqual(field.value, 2025)
        XCTAssertEqual(field.validity, .valid)
    }

    func testCalendarComponent() {
        let field = DateTimeField(type: .month, value: 1)
        XCTAssertEqual(field.type.calendarComponent(), .month)
    }

}
