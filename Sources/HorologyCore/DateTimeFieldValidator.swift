//
//  DateTimeFieldValidator.swift
//  Horology
//
//  Created by Paul Schifferer on 18/9/17.
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


class DateTimeFieldValidator {

    private var field : DateTimeField

    init(field : DateTimeField) {
        self.field = field
    }

    func validate(using calendar : Calendar) throws {
        guard let minValue = calendar.minimumRange(of: field.type.calendarComponent()) else { throw DateTimeFieldValidationError.invalidRange(field.type) }
        guard let maxValue = calendar.maximumRange(of: field.type.calendarComponent()) else { throw DateTimeFieldValidationError.invalidRange(field.type) }

        guard minValue.contains(field.value) && maxValue.contains(field.value) else { throw DateTimeFieldValidationError.outOfRange(field.type) }

        // all good
        return
    }
}


enum DateTimeFieldValidationError : Error {
    case invalidRange(DateTimeFieldType)
    case outOfRange(DateTimeFieldType)
}
