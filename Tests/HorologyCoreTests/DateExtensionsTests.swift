//
//  DateExtensionsTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var extensions: Self
}

@Suite(.tags(.date, .extensions))
struct DateExtensionsTests {

    @Test
    func testConvert() throws {
        let date = Date()
        let fromCalendar = Calendar(identifier: .gregorian)
        let toCalendar = Calendar(identifier: .buddhist)

        _ = try #require(date.convert(fromCalendar: fromCalendar, toCalendar: toCalendar))
    }

    @Test
    func testConvertWithSameCalendar() throws {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)

        let convertedDate = date.convert(fromCalendar: calendar, toCalendar: calendar)

        _ = try #require(convertedDate)
        #expect(Int(date.timeIntervalSince1970) == Int(convertedDate?.timeIntervalSince1970 ?? 0))
    }

}
