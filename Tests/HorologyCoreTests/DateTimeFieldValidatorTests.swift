//
//  DateTimeFieldValidatorTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Testing
@testable import HorologyCore


extension Tag {
    @Tag static var validator: Self
}

@Suite(.tags(.dateTimeField, .validator))
struct DateTimeFieldValidatorTests {

    @Test
    func testValidation() throws {
        let field = DateTimeField(type: .day, value: 15)
        let validator = DateTimeFieldValidator(field: field)
        let calendar = Calendar(identifier: .gregorian)

        try validator.validate(using: calendar)
    }

    @Test
    func testValidationWithInvalidValue() throws {
        let field = DateTimeField(type: .day, value: 32)
        let validator = DateTimeFieldValidator(field: field)
        let calendar = Calendar(identifier: .gregorian)

        do {
            try validator.validate(using: calendar)
            Issue.record("Validation should have failed")
        }
        catch DateTimeFieldValidationError.outOfRange(let type) {
            #expect(type == .day, "Expected day type")
        }
    }

}
