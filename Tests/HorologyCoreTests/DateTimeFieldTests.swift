//
//  DateTimeFieldTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var dateTimeField: Self
}

@Suite(.tags(.dateTimeField))
struct DateTimeFieldTests {

    @Test
    func testInitialization() {
        let field = DateTimeField(type: .year, value: 2025)
        #expect(field.type == .year)
        #expect(field.value == 2025)
        #expect(field.validity == .valid)
    }

    @Test
    func testCalendarComponent() {
        let field = DateTimeField(type: .month, value: 1)
        #expect(field.type.calendarComponent() == .month)
    }

}
