//
//  CommonFunctionTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var common: Self
}

@Suite(.tags(.common))
struct CommonFunctionTests {

    @Test
    func testHandleAdjustment() {
        let result = handleAdjustment(by: 1, on: .year, with: DateFields(year: DateTimeField(type: .year, value: 2023)))
        #expect(result?.year?.value == 2024)
    }

    @Test
    func testHandleValue() {
        let result = handleValue(2023, on: .year, with: DateFields(year: DateTimeField(type: .year, value: 2023)))
        #expect(result?.year?.value == 2023)
    }

}
