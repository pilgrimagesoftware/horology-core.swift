//
//  DateCalculatorTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateCalculatorTests: XCTestCase {
    func testDateCalculationDateOnly() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1))
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1))

        do {
            let result = try calculator.calculateDate(with: .dateOnly)
            let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 2025, month: 1, day: 2))
            XCTAssertEqual(result, expectedDate)
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testDateCalculationTimeOnly() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1),
                                          hour: DateTimeField(type: .hour, value: 0),
                                          minute: DateTimeField(type: .minute, value: 0),
                                          second: DateTimeField(type: .second, value: 0))
        calculator.adjustments = DateFields(hour: DateTimeField(type: .hour, value: 1),
                                            minute: DateTimeField(type: .minute, value: 30),
                                            second: DateTimeField(type: .second, value: 0))

        do {
            let result = try calculator.calculateDate(with: .timeOnly)
            let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 2025, month: 1, day: 1, hour: 1, minute: 30))
            XCTAssertEqual(result, expectedDate)
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testDateCalculationDateAndTime() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1),
                                          hour: DateTimeField(type: .hour, value: 0),
                                          minute: DateTimeField(type: .minute, value: 0),
                                          second: DateTimeField(type: .second, value: 0))
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1),
                                            hour: DateTimeField(type: .hour, value: 1),
                                            minute: DateTimeField(type: .minute, value: 30),
                                            second: DateTimeField(type: .second, value: 0))

        do {
            let result = try calculator.calculateDate(with: .dateAndTime)
            let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 2025, month: 1, day: 2, hour: 1, minute: 30))
            XCTAssertEqual(result, expectedDate)
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testDateCalculationInvalidDate() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 32)) // Invalid date
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1))

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            // XCTAssertEqual(error as? CalculationError, .conversionError)
        }
    }

    func testDateCalculationInvalidAdjustment() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1))
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: -1)) // Invalid adjustment

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            // XCTAssertEqual(error as? CalculationError, .conversionError)
        }
    }

    func testDateCalculationConversionError() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1))
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1))

        // Simulate a conversion error
        calculator.calendar = Calendar(identifier: .gregorian) // Use a different calendar

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            // XCTAssertEqual(error as? CalculationError, .conversionError)
        }
    }
}
