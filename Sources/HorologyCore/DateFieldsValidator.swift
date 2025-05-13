//
//  DateFieldsValidator.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


public class DateFieldsValidator {

    private var fields : DateFields

    public init(fields : DateFields) {
        self.fields = fields
    }

    public func validate(using mode : DateTimeMode, calendar : Calendar) throws {
        if mode == .dateAndTime || mode == .dateOnly {
            // year
            guard let year = fields.year else { throw DateFieldsValidationError.missingField(.year) }
            try DateTimeFieldValidator(field: year).validate(using: calendar)

            // month
            guard let month = fields.month else { throw DateFieldsValidationError.missingField(.month) }
            try DateTimeFieldValidator(field: month).validate(using: calendar)

            // day
            guard let day = fields.day else { throw DateFieldsValidationError.missingField(.day) }
            try DateTimeFieldValidator(field: day).validate(using: calendar)
        }
        else if mode == .dateAndTime || mode == .timeOnly {
            // hour
            guard let hour = fields.hour else { throw DateFieldsValidationError.missingField(.hour) }
            try DateTimeFieldValidator(field: hour).validate(using: calendar)

            // minute
            guard let minute = fields.minute else { throw DateFieldsValidationError.missingField(.minute) }
            try DateTimeFieldValidator(field: minute).validate(using: calendar)

            // second
            guard let second = fields.second else { throw DateFieldsValidationError.missingField(.second) }
            try DateTimeFieldValidator(field: second).validate(using: calendar)
        }

        // all good
        return
    }

}


public enum DateFieldsValidationError : Error {
    case missingField(DateTimeFieldType)
}
