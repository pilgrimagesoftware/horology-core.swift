//
//  DateComparerTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
@testable import HorologyCore


@Suite(.tags(.date, .comparator))
struct DateComparerTests {

    @Test
    func testDateComparerWithOnlyDate() throws {
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                            month: DateTimeField(type: .month, value: 1),
                                            day: DateTimeField(type: .day, value: 1))
        dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
                                             month: DateTimeField(type: .month, value: 1),
                                             day: DateTimeField(type: .day, value: 2))

        let result = try dateComparer.calculate(with: .dateOnly)
        #expect(result.year == 0)
        #expect(result.month == 0)
        #expect(result.day == 1)
    }

    @Test
    func testDateComparerWithOnlyTime() throws{
        let dateComparer = DateComparer()
        dateComparer.firstDate = DateFields(hour: DateTimeField(type: .hour, value: 12),
                                            minute: DateTimeField(type: .minute, value: 0),
                                            second: DateTimeField(type: .second, value: 0))
        dateComparer.secondDate = DateFields(hour: DateTimeField(type: .hour, value: 13),
                                             minute: DateTimeField(type: .minute, value: 0),
                                             second: DateTimeField(type: .second, value: 0))

        let result = try dateComparer.calculate(with: .timeOnly)
        #expect(result.hour == 1)
        #expect(result.minute == 0)
        #expect(result.second == 0)
    }

    @Test
    func testDateComparerWithDateAndTime() throws {
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

        let result = try dateComparer.calculate(with: .dateAndTime)
        #expect(result.year == 0)
        #expect(result.month == 0)
        #expect(result.day == 1)
        #expect(result.hour == 1)
        #expect(result.minute == 0)
        #expect(result.second == 0)
    }

    // func testDateComparerWithInvalidDate() {
    //     let dateComparer = DateComparer()
    //     dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
    //                                         month: DateTimeField(type: .month, value: 1),
    //                                         day: DateTimeField(type: .day, value: 1))
    //     dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
    //                                          month: DateTimeField(type: .month, value: 1),
    //                                          day: DateTimeField(type: .day, value: 32)) // Invalid day

    //     do {
    //         _ = try dateComparer.calculate(with: .dateOnly)
    //         XCTFail("Expected an error, but got none")
    //     }
    //      catch {
    //         XCTAssertTrue(error is ComparisonError)
    //     }
    // }

    // func testDateComparerWithInvalidTime() {
    //     let dateComparer = DateComparer()
    //     dateComparer.firstDate = DateFields(hour: DateTimeField(type: .hour, value: 12),
    //                                         minute: DateTimeField(type: .minute, value: 0),
    //                                         second: DateTimeField(type: .second, value: 0))
    //     dateComparer.secondDate = DateFields(hour: DateTimeField(type: .hour, value: 25),
    //                                          minute: DateTimeField(type: .minute, value: 0),
    //                                          second: DateTimeField(type: .second, value: 0)) // Invalid hour

    //     do {
    //         _ = try dateComparer.calculate(with: .timeOnly)
    //         XCTFail("Expected an error, but got none")
    //     }
    //     catch {
    //         XCTAssertTrue(error is ComparisonError)
    //     }
    // }

    // func testDateComparerWithInvalidDateAndTime() {
    //     let dateComparer = DateComparer()
    //     dateComparer.firstDate = DateFields(year: DateTimeField(type: .year, value: 2025),
    //                                         month: DateTimeField(type: .month, value: 1),
    //                                         day: DateTimeField(type: .day, value: 1),
    //                                         hour: DateTimeField(type: .hour, value: 12),
    //                                         minute: DateTimeField(type: .minute, value: 0),
    //                                         second: DateTimeField(type: .second, value: 0))
    //     dateComparer.secondDate = DateFields(year: DateTimeField(type: .year, value: 2025),
    //                                          month: DateTimeField(type: .month, value: 1),
    //                                          day: DateTimeField(type: .day, value: 2),
    //                                          hour: DateTimeField(type: .hour, value: 25),
    //                                          minute: DateTimeField(type: .minute, value: 0),
    //                                          second: DateTimeField(type: .second, value: 0)) // Invalid hour

    //     do {
    //         _ = try dateComparer.calculate(with: .dateAndTime)
    //         XCTFail("Expected an error, but got none")
    //     }
    //     catch {
    //         XCTAssertTrue(error is ComparisonError)
    //     }
    // }

}
