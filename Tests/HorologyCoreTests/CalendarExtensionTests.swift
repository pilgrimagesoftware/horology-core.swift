//
//  CalendarExtensions.swift
//  Horology
//
//  Created by Paul Schifferer on 29/8/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class CalendarExtensionTests: XCTestCase {
    func testFrom() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        XCTAssertEqual(calendar.identifier, .gregorian)
    }

    func testAsString() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        XCTAssertEqual(calendar.asString(), "gregorian")
    }

    func testLabel() throws {
        let calendar = Calendar.from(identifier: "gregorian")
        XCTAssertEqual(calendar.label, "calendar.identifier.gregorian")
    }
}
