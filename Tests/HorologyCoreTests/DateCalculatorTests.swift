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
        calculator.startDate = DateFields(year: 2025, month: 1, day: 1)
        calculator.adjustments = DateFields(year: 0, month: 0, day: 1)

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
        calculator.startDate = DateFields(year: 2025, month: 1, day: 1, hour: 0, minute: 0, second: 0)
        calculator.adjustments = DateFields(hour: 1, minute: 30, second: 0)

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
        calculator.startDate = DateFields(year: 2025, month: 1, day: 1, hour: 0, minute: 0, second: 0)
        calculator.adjustments = DateFields(year: 0, month: 0, day: 1, hour: 1, minute: 30, second: 0)

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
        calculator.startDate = DateFields(year: 2025, month: 1, day: 32) // Invalid date
        calculator.adjustments = DateFields(year: 0, month: 0, day: 1)

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            XCTAssertEqual(error as? DateCalculatorError, .invalidDate)
        }
    }

    func testDateCalculationInvalidAdjustment() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: 2025, month: 1, day: 1)
        calculator.adjustments = DateFields(year: 0, month: 0, day: -1) // Invalid adjustment

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            XCTAssertEqual(error as? DateCalculatorError, .invalidAdjustment)
        }
    }

    func testDateCalculationConversionError() {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: 2025, month: 1, day: 1)
        calculator.adjustments = DateFields(year: 0, month: 0, day: 1)

        // Simulate a conversion error
        calculator.calendar = Calendar(identifier: .gregorian) // Use a different calendar

        XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
            XCTAssertEqual(error as? CalculationError, .conversionError(calculator.startDate))
        }
    }
}
