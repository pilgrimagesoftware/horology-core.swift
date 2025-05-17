//
//  ValueConverterTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
import Logging
@testable import HorologyCore


extension Tag {
    @Tag static var conversion: Self
}

@Suite(.tags(.conversion))
struct ValueConverterTests {
    let data : [(String, String, Int, Bool)] = [
        ("years", "months", 12, false),
        ("years", "weeks", 53, true),
        ("years", "days", 372, true),
        ("years", "hours", 8928, true),
        ("years", "minutes", 535680, true),
        ("years", "seconds", 32140800, true),
        ("months", "weeks", 4, true),
        ("months", "days", 31, true),
        ("months", "hours", 744, true),
        ("months", "minutes", 44640, true),
        ("months", "seconds", 2678400, true),
        ("weeks", "days", 7, false),
        ("weeks", "hours", 168, false),
        ("weeks", "minutes", 10080, false),
        ("weeks", "seconds", 604800, false),
        ("days", "hours", 24, false),
        ("days", "minutes", 1440, false),
        ("days", "seconds", 86400, false),
        ("hours", "minutes", 60, false),
        ("hours", "seconds", 3600, false),
        ("minutes", "seconds", 60, false),
        ("dog-years", "years", 10, true),
        ("cat-years", "years", 15, true),
    ]

    @Test
    func conversionTests() throws {
        for (fromUnit, toUnit, expectedValue, approximate) in data {
            let fromType = try #require(ConversionValueType(rawValue: fromUnit))
            let toType = try #require(ConversionValueType(rawValue: toUnit))

            let result = try ValueConverter(value: 1, valueType: fromType)
                .convert(to: toType)

            #expect(result.value == expectedValue, "\(fromType) -> \(toType) expected value is incorrect")
            #expect(result.approximate == approximate, "\(fromType) -> \(toType) approximate value is incorrect")
        }
    }

}
