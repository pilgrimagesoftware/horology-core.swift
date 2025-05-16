//
//  DateFieldsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var dateFields: Self
}

@Suite(.tags(.dateFields))
struct DateFieldsTests {

    @Test
    func testInitializationFromComponents() {
        let components = DateComponents(year: 2025, month: 1, day: 1, hour: 12, minute: 30, second: 45)
        let dateFields = DateFields(components: components)

        #expect(dateFields.year?.value == 2025)
        #expect(dateFields.month?.value == 1)
        #expect(dateFields.day?.value == 1)
        #expect(dateFields.hour?.value == 12)
        #expect(dateFields.minute?.value == 30)
        #expect(dateFields.second?.value == 45)
    }

    @Test
    func testInitializationFromFields() {
        let fields = [
            DateTimeField(type: .year, value: 2025),
            DateTimeField(type: .month, value: 1),
            DateTimeField(type: .day, value: 1),
            DateTimeField(type: .hour, value: 12),
            DateTimeField(type: .minute, value: 30),
            DateTimeField(type: .second, value: 45)
        ]
        let dateFields = DateFields(fields: fields)

        #expect(dateFields.year?.value == 2025)
        #expect(dateFields.month?.value == 1)
        #expect(dateFields.day?.value == 1)
        #expect(dateFields.hour?.value == 12)
        #expect(dateFields.minute?.value == 30)
        #expect(dateFields.second?.value == 45)
    }

    @Test
    func testInitializationWithNilValues() {
        let fields = DateFields(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil)
        #expect(fields.year == nil)
        #expect(fields.month == nil)
        #expect(fields.day == nil)
        #expect(fields.hour == nil)
        #expect(fields.minute == nil)
        #expect(fields.second == nil)
    }

    @Test
    func testDate() throws {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        _ = try #require(fields.date(using: .autoupdatingCurrent))
    }

    @Test
    func testDateAsComponents() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let components = fields.asComponents()

        #expect(components.year == 2025)
        #expect(components.month == 1)
        #expect(components.day == 1)
        #expect(components.hour == 12)
        #expect(components.minute == 30)
        #expect(components.second == 45)
    }

    @Test
    func testDateAsFields() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let dateFields = fields.asFields()

        #expect(dateFields.count == 6)
        #expect(dateFields[0].type == DateTimeFieldType.year)
        #expect(dateFields[0].value == 2025)
        #expect(dateFields[1].type == DateTimeFieldType.month)
        #expect(dateFields[1].value == 1)
        #expect(dateFields[2].type == DateTimeFieldType.day)
        #expect(dateFields[2].value == 1)
        #expect(dateFields[3].type == DateTimeFieldType.hour)
        #expect(dateFields[3].value == 12)
        #expect(dateFields[4].type == DateTimeFieldType.minute)
        #expect(dateFields[4].value == 30)
        #expect(dateFields[5].type == DateTimeFieldType.second)
        #expect(dateFields[5].value == 45)
    }

}
