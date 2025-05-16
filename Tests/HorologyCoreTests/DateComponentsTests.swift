//
//  DateComponentsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var components: Self
}

@Suite(.tags(.date, .components))
struct DateComponentsTests {

    @Test
    func testDateComponentsFromFields() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let components = DateComponents.from(fields: fields)

        #expect(components.year == 2025)
        #expect(components.month == 1)
        #expect(components.day == 1)
        #expect(components.hour == 12)
        #expect(components.minute == 30)
        #expect(components.second == 45)
    }

    @Test
    func testDateComponentsFromFieldsWithNilValues() {
        let fields = DateFields(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil)
        let components = DateComponents.from(fields: fields)

        #expect(components.year == nil)
        #expect(components.month == nil)
        #expect(components.day == nil)
        #expect(components.hour == nil)
        #expect(components.minute == nil)
        #expect(components.second == nil)
    }

    @Test
    func testDateComponentsFromFieldsWithPartialValues() {
        let fields = DateFields(year: DateTimeField(type: .year, value:2025),
                                month: nil,
                                day: DateTimeField(type: .day, value: 1),
                                hour: nil,
                                minute: DateTimeField(type: .minute, value: 30),
                                second: nil)
        let components = DateComponents.from(fields: fields)

        #expect(components.year == 2025)
        #expect(components.month == nil)
        #expect(components.day == 1)
        #expect(components.hour == nil)
        #expect(components.minute == 30)
        #expect(components.second == nil)
    }

    @Test
    func testDateComponentsFromFieldsWithNegativeValues() {
        let fields = DateFields(year: DateTimeField(type: .year, value: -2025),
                                month: DateTimeField(type: .month, value: -1),
                                day: DateTimeField(type: .day, value: -1),
                                hour: DateTimeField(type: .hour, value: -12),
                                minute: DateTimeField(type: .minute, value: -30),
                                second: DateTimeField(type: .second, value: -45))
        let components = DateComponents.from(fields: fields)

        #expect(components.year == -2025)
        #expect(components.month == -1)
        #expect(components.day == -1)
        #expect(components.hour == -12)
        #expect(components.minute == -30)
        #expect(components.second == -45)
    }

    @Test
    func testDateComponentsFromFieldsWithZeroValues() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 0),
                                month: DateTimeField(type: .month, value: 0),
                                day: DateTimeField(type: .day, value: 0),
                                hour: DateTimeField(type: .hour, value: 0),
                                minute: DateTimeField(type: .minute, value: 0),
                                second: DateTimeField(type: .second, value: 0))
        let components = DateComponents.from(fields: fields)

        #expect(components.year == 0)
        #expect(components.month == 0)
        #expect(components.day == 0)
        #expect(components.hour == 0)
        #expect(components.minute == 0)
        #expect(components.second == 0)
    }

}
