//
//  ComparatorDateTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class ComparatorDateTests: XCTestCase {
    func testComparatorDateInitialization() {
        let comparatorDate = ComparatorDate()
        // let now = Calendar.

        XCTAssertEqual(comparatorDate.calendarId, Calendar.autoupdatingCurrent.asString())
        // XCTAssertEqual(comparatorDate.fromYear, 2025)
        // XCTAssertEqual(comparatorDate.fromMonth, 0)
        // XCTAssertEqual(comparatorDate.fromDay, 1)
        // XCTAssertEqual(comparatorDate.fromHour, 0)
        // XCTAssertEqual(comparatorDate.fromMinute, 0)
        // XCTAssertEqual(comparatorDate.fromSecond, 0)
        // XCTAssertEqual(comparatorDate.toYear, 2025)
        // XCTAssertEqual(comparatorDate.toMonth, 0)
        // XCTAssertEqual(comparatorDate.toDay, 1)
        // XCTAssertEqual(comparatorDate.toHour, 0)
        // XCTAssertEqual(comparatorDate.toMinute, 0)
        // XCTAssertEqual(comparatorDate.toSecond, 0)
    }
}
