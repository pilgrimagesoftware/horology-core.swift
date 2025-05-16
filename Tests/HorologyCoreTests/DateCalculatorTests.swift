//
//  DateCalculatorTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var calculator: Self
}

@Suite(.tags(.calculator, .date))
struct DateCalculatorTests {

    @Test
    func testDateCalculationDateOnly() throws {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 1))
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1))

        let result = try calculator.calculateDate(with: .dateOnly)
        let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 2025, month: 1, day: 2))
        #expect(result == expectedDate)
    }

    @Test
    func testDateCalculationTimeOnly() throws{
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

        let result = try calculator.calculateDate(with: .timeOnly)
        let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 0, month: 0, day: 0, hour: 1, minute: 30))
        #expect(Int(result.timeIntervalSince1970) == Int(expectedDate?.timeIntervalSince1970 ?? 0))
    }

    @Test
    func testDateCalculationDateAndTime() throws{
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

        let result = try calculator.calculateDate(with: .dateAndTime)
        let expectedDate = Calendar.autoupdatingCurrent.date(from: DateComponents(year: 2025, month: 1, day: 2, hour: 1, minute: 30))
        #expect(Int(result.timeIntervalSince1970) == Int(expectedDate?.timeIntervalSince1970 ?? 0))
    }

    @Test
    func testDateCalculationInvalidDate() throws {
        let calculator = DateCalculator()
        calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                          month: DateTimeField(type: .month, value: 1),
                                          day: DateTimeField(type: .day, value: 32)) // Invalid date
        calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
                                            month: DateTimeField(type: .month, value: 0),
                                            day: DateTimeField(type: .day, value: 1))

        #expect(throws: (any Error).self) {
            try calculator.calculateDate(with: .dateOnly)
        }
    }

    // func testDateCalculationConversionError() {
    //     let calculator = DateCalculator()
    //     calculator.startDate = DateFields(year: DateTimeField(type: .year, value: 2025),
    //                                       month: DateTimeField(type: .month, value: 1),
    //                                       day: DateTimeField(type: .day, value: 1))
    //     calculator.adjustments = DateFields(year: DateTimeField(type: .year, value: 0),
    //                                         month: DateTimeField(type: .month, value: 0),
    //                                         day: DateTimeField(type: .day, value: 1))

    //     // Simulate a conversion error
    //     calculator.calendar = Calendar(identifier: .buddhist) // Use a different calendar

    //     XCTAssertThrowsError(try calculator.calculateDate(with: .dateOnly)) { error in
    //         // #expect(error as? CalculationError, .conversionError)
    //     }
    // }

}
