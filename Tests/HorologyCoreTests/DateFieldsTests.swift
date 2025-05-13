//
//  DateFieldsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateFieldsTests: XCTestCase {

    func testInitializationFromComponents() {
        let components = DateComponents(year: 2025, month: 1, day: 1, hour: 12, minute: 30, second: 45)
        let dateFields = DateFields(components: components)

        XCTAssertEqual(dateFields.year?.value, 2025)
        XCTAssertEqual(dateFields.month?.value, 1)
        XCTAssertEqual(dateFields.day?.value, 1)
        XCTAssertEqual(dateFields.hour?.value, 12)
        XCTAssertEqual(dateFields.minute?.value, 30)
        XCTAssertEqual(dateFields.second?.value, 45)
    }

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

        XCTAssertEqual(dateFields.year?.value, 2025)
        XCTAssertEqual(dateFields.month?.value, 1)
        XCTAssertEqual(dateFields.day?.value, 1)
        XCTAssertEqual(dateFields.hour?.value, 12)
        XCTAssertEqual(dateFields.minute?.value, 30)
        XCTAssertEqual(dateFields.second?.value, 45)
    }

    func testInitializationWithNilValues() {
        let fields = DateFields(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil)
        XCTAssertNil(fields.year)
        XCTAssertNil(fields.month)
        XCTAssertNil(fields.day)
        XCTAssertNil(fields.hour)
        XCTAssertNil(fields.minute)
        XCTAssertNil(fields.second)
    }

    func testDate() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let date = fields.date(using: .autoupdatingCurrent)

        XCTAssertNotNil(date)
    }

    func testDateAsComponents() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let components = fields.asComponents()

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 12)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }

    func testDateAsFields() {
        let fields = DateFields(year: DateTimeField(type: .year, value: 2025),
                                month: DateTimeField(type: .month, value: 1),
                                day: DateTimeField(type: .day, value: 1),
                                hour: DateTimeField(type: .hour, value: 12),
                                minute: DateTimeField(type: .minute, value: 30),
                                second: DateTimeField(type: .second, value: 45))
        let dateFields = fields.asFields()

        XCTAssertEqual(dateFields.count, 6)
        XCTAssertEqual(dateFields[0].type, DateTimeFieldType.year)
        XCTAssertEqual(dateFields[0].value, 2025)
        XCTAssertEqual(dateFields[1].type, DateTimeFieldType.month)
        XCTAssertEqual(dateFields[1].value, 1)
        XCTAssertEqual(dateFields[2].type, DateTimeFieldType.day)
        XCTAssertEqual(dateFields[2].value, 1)
        XCTAssertEqual(dateFields[3].type, DateTimeFieldType.hour)
        XCTAssertEqual(dateFields[3].value, 12)
        XCTAssertEqual(dateFields[4].type, DateTimeFieldType.minute)
        XCTAssertEqual(dateFields[4].value, 30)
        XCTAssertEqual(dateFields[5].type, DateTimeFieldType.second)
        XCTAssertEqual(dateFields[5].value, 45)
    }
}
