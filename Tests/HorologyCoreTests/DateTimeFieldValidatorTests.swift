//
//  DateTimeFieldValidatorTests.swift
//  Horology Core Tests
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import XCTest
@testable import HorologyCore


final class DateTimeFieldValidatorTests: XCTestCase {

    func testValidation() {
        let field = DateTimeField(type: .day, value: 15)
        let validator = DateTimeFieldValidator(field: field)
        let calendar = Calendar(identifier: .gregorian)

        do {
            try validator.validate(using: calendar)
            XCTAssertTrue(true, "Validation passed")
        }
        catch {
            XCTFail("Validation failed with error: \(error)")
        }
    }

    func testValidationWithInvalidValue() {
        let field = DateTimeField(type: .day, value: 32)
        let validator = DateTimeFieldValidator(field: field)
        let calendar = Calendar(identifier: .gregorian)

        do {
            try validator.validate(using: calendar)
            XCTFail("Validation should have failed")
        }
        catch DateTimeFieldValidationError.outOfRange(let type) {
            XCTAssertEqual(type, .day, "Expected day type")
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

}
