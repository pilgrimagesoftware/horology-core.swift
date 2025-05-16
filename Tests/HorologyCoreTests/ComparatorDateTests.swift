//
//  ComparatorDateTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var date: Self
    @Tag static var comparator: Self
}

@Suite(.tags(.date, .comparator))
struct ComparatorDateTests {

    @Test
    func testComparatorDateInitialization() {
        let comparatorDate = ComparatorDate()
        // let now = Calendar.

        #expect(comparatorDate.calendarId == Calendar.autoupdatingCurrent.asString())
        // #expect(comparatorDate.fromYear, 2025)
        // #expect(comparatorDate.fromMonth, 0)
        // #expect(comparatorDate.fromDay, 1)
        // #expect(comparatorDate.fromHour, 0)
        // #expect(comparatorDate.fromMinute, 0)
        // #expect(comparatorDate.fromSecond, 0)
        // #expect(comparatorDate.toYear, 2025)
        // #expect(comparatorDate.toMonth, 0)
        // #expect(comparatorDate.toDay, 1)
        // #expect(comparatorDate.toHour, 0)
        // #expect(comparatorDate.toMinute, 0)
        // #expect(comparatorDate.toSecond, 0)
    }

}
