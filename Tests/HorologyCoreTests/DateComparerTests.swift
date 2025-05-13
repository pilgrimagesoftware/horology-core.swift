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
        dateComparer.firstDate = DateFields(year: 2025, month: 1, day: 1)
        dateComparer.secondDate = DateFields(year: 2025, month: 1, day: 2)

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
        dateComparer.firstDate = DateFields(hour: 12, minute: 0, second: 0)
        dateComparer.secondDate = DateFields(hour: 13, minute: 0, second: 0)

        do {
            let result = try dateComparer.calculate(with: .timeOnly)
            XCTAssertEqual(result.hour, -1)
            XCTAssertEqual(result.minute, 0)
            XCTAssertEqual(result.second, 0)
        }
         catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }

    func testDateComparerWithDateAndTime() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: 2025, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        dateComparer.secondDate = DateFields(year: 2025, month: 1, day: 2, hour: 13, minute: 0, second: 0)

        do {
            let result = try dateComparer.calculate(with: .both)
            XCTAssertEqual(result.year, 0)
            XCTAssertEqual(result.month, 0)
            XCTAssertEqual(result.day, -1)
            XCTAssertEqual(result.hour, -1)
            XCTAssertEqual(result.minute, 0)
            XCTAssertEqual(result.second, 0)
        }
         catch {
            XCTFail("Expected no error, but got \(error)")
        }
    }

    func testDateComparerWithInvalidDate() {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: 2025, month: 1, day: 1)
        dateComparer.secondDate = DateFields(year: 2025, month: 1, day: 32) // Invalid day

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
        dateComparer.firstDate = DateFields(hour: 12, minute: 0, second: 0)
        dateComparer.secondDate = DateFields(hour: 25, minute: 0, second: 0) // Invalid hour

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
        dateComparer.firstDate = DateFields(year: 2025, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        dateComparer.secondDate = DateFields(year: 2025, month: 1, day: 2, hour: 25, minute: 0, second: 0) // Invalid hour

        do {
            _ = try dateComparer.calculate(with: .both)
            XCTFail("Expected an error, but got none")
        }
        catch {
            XCTAssertTrue(error is ComparisonError)
        }
    }
}
