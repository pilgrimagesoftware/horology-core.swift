//
//  DateTimeFieldValidator.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


public class DateTimeFieldValidator {

    private var field : DateTimeField

    public init(field : DateTimeField) {
        self.field = field
    }

    public func validate(using calendar : Calendar) throws {
        guard let minValue = calendar.minimumRange(of: field.type.calendarComponent()) else { throw DateTimeFieldValidationError.invalidRange(field.type) }
        guard let maxValue = calendar.maximumRange(of: field.type.calendarComponent()) else { throw DateTimeFieldValidationError.invalidRange(field.type) }

        guard minValue.contains(field.value) && maxValue.contains(field.value) else { throw DateTimeFieldValidationError.outOfRange(field.type) }

        // all good
        return
    }
}


public enum DateTimeFieldValidationError : Error {
    case invalidRange(DateTimeFieldType)
    case outOfRange(DateTimeFieldType)
}
