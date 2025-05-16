//
//  CalendarExtensionTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var calendar: Self
}

@Suite(.tags(.calendar))
struct CalendarExtensionTests {

    @Test
    func testFrom() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        #expect(calendar.identifier == .gregorian)
    }

    @Test
    func testAsString() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        #expect(calendar.asString() == "gregorian")
    }

    @Test
    func testLabel() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        #expect(calendar.label == "calendar.identifier.gregorian")
    }

}
