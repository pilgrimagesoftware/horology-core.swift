//
//  DateComparerTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateComparerTests: XCTestCase {
    func testDateComparerWithOnlyDate() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                            month: DateTimeField(type: .month, value: 1),
                                            day: DateTimeField(type: .day, value: 1))
        dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                             month: DateTimeField(type: .month, value: 1),
                                             day: DateTimeField(type: .day, value: 2))

        do {
            let result = try dateComparer.calculate(with: .dateOnly)
            XCTAssertEqual(result.year, 0)
            XCTAssertEqual(result.month, 0)
            XCTAssertEqual(result.day, -1)
        }
        catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }

    func testDateComparerWithOnlyTime() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(hour: DateTimeField(type: .hour, value: 12),
                                            minute: DateTimeField(type: .minute, value: 0),
                                            second: DateTimeField(type: .second, value: 0))
        dateComparer.secondDate = DateFields(hour: DateTimeField(type: .hour, value: 13),
                                             minute: DateTimeField(type: .minute, value: 0),
                                             second: DateTimeField(type: .second, value: 0))

        do {
            let result = try dateComparer.calculate(with: .timeOnly)
            XCTAssertEqual(result.hour, 1)
            XCTAssertEqual(result.minute, 0)
            XCTAssertEqual(result.second, 0)
        }
         catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }

    func testDateComparerWithDateAndTime() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                            month: DateTimeField(type: .month, value: 1),
                                            day: DateTimeField(type: .day, value: 1),
                                            hour: DateTimeField(type: .hour, value: 12),
                                            minute: DateTimeField(type: .minute, value: 0),
                                            second: DateTimeField(type: .second, value: 0))
        dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                             month: DateTimeField(type: .month, value: 1),
                                             day: DateTimeField(type: .day, value: 2),
                                             hour: DateTimeField(type: .hour, value: 13),
                                             minute: DateTimeField(type: .minute, value: 0),
                                             second: DateTimeField(type: .second, value: 0))

        do {
            let result = try dateComparer.calculate(with: .dateAndTime)
            XCTAssertEqual(result.year, 0)
            XCTAssertEqual(result.month, 0)
            XCTAssertEqual(result.day, 1)
            XCTAssertEqual(result.hour, 1)
            XCTAssertEqual(result.minute, 0)
            XCTAssertEqual(result.second, 0)
        }
         catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }

    func testDateComparerWithInvalidDate() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                            month: DateTimeField(type: .month, value: 1),
                                            day: DateTimeField(type: .day, value: 1))
        dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                             month: DateTimeField(type: .month, value: 1),
                                             day: DateTimeField(type: .day, value: 32)) // Invalid day

        do {
            _ = try dateComparer.calculate(with: .dateOnly)
            XCTFail("Expected an error, but got none")
        }
         catch {
            XCTAssertTrue(error is ComparisonError)
        }
    }

    func testDateComparerWithInvalidTime() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(hour: DateTimeField(type: .hour, value: 12),
                                            minute: DateTimeField(type: .minute, value: 0),
                                            second: DateTimeField(type: .second, value: 0))
        dateComparer.secondDate = DateFields(hour: DateTimeField(type: .hour, value: 25),
                                             minute: DateTimeField(type: .minute, value: 0),
                                             second: DateTimeField(type: .second, value: 0)) // Invalid hour

        do {
            _ = try dateComparer.calculate(with: .timeOnly)
            XCTFail("Expected an error, but got none")
        }
        catch {
            XCTAssertTrue(error is ComparisonError)
        }
    }

    func testDateComparerWithInvalidDateAndTime() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                            month: DateTimeField(type: .month, value: 1),
                                            day: DateTimeField(type: .day, value: 1),
                                            hour: DateTimeField(type: .hour, value: 12),
                                            minute: DateTimeField(type: .minute, value: 0),
                                            second: DateTimeField(type: .second, value: 0))
        dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                             month: DateTimeField(type: .month, value: 1),
                                             day: DateTimeField(type: .day, value: 2),
                                             hour: DateTimeField(type: .hour, value: 25),
                                             minute: DateTimeField(type: .minute, value: 0),
                                             second: DateTimeField(type: .second, value: 0)) // Invalid hour

        do {
            _ = try dateComparer.calculate(with: .dateAndTime)
            XCTFail("Expected an error, but got none")
        }
        catch {
            XCTAssertTrue(error is ComparisonError)
        }
    }
}
