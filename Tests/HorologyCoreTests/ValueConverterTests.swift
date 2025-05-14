//
//  ValueConverterTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var conversion: Self
}

@Suite
struct ValueConverterTests {
    let data : [(String, String, Int, Bool)] = [
        ("years", "seconds", 32140800, true),
        ("months", "seconds", 2678400, true),
        ("months", "days", 31, true),
        ("days", "seconds", 86400, false),
        ("days", "hours", 24, false),
        ("weeks", "days", 7, false),
        ("days", "minutes", 1440, false),
        ("hours", "seconds", 3600, false),
        ("hours", "minutes", 60, false),
        ("minutes", "seconds", 60, false),
        ("dog-years", "years", 10, true),
        ("cat-years", "years", 15, true),
    ]

    @Test(.tags(.conversion))
    func conversionTests() async throws {
        for (fromUnit, toUnit, expectedValue, approximate) in data {
            let fromType = try #require(ConversionValueType(rawValue: fromUnit))
            let toType = try #require(ConversionValueType(rawValue: toUnit))

            let result = ValueConverter(value: 1, valueType: fromType)
                .convert(to: toType)

            #expect(result.value == expectedValue, "\(fromType) -> \(toType) expected value is incorrect")
            #expect(result.approximate == approximate, "\(fromType) -> \(toType) approximate value is incorrect")
        }
    }

}
