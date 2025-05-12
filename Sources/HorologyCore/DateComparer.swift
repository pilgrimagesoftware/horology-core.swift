//
//  DateComparer.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


/**
 Initialize an instance of this class with a calendar and the two dates to compare. Call `calculate(with:)` whenever`
 a result is desired.
 */
class DateComparer {

    var firstDate : DateFields = DateFields()
    var secondDate : DateFields = DateFields()
    var calendar : Calendar = Calendar.autoupdatingCurrent

    /**
     Perform a date comparison with the two dates provided, using the configured calendar. If the date values are
     invalid, throws a validation error with an explanation that may be shown to the user.

     - parameter with: The mode to use for performing the comparison, i.e., only dates, only times, or both.
     - returns: the comparison result in a DateComponents value object
     - throws: validation error if either date is incomplete or invalid
     */
    func calculate(with mode : DateTimeMode) throws -> DateComponents {
        // validate the first date
        try DateFieldsValidator(fields: self.firstDate).validate(using: mode, calendar: self.calendar)
        // validate the second date
        try DateFieldsValidator(fields: self.secondDate).validate(using: mode, calendar: self.calendar)

        var firstComps = DateComponents.from(fields: self.firstDate)
        var secondComps = DateComponents.from(fields: self.secondDate)

        switch mode {
        case .dateOnly:
            firstComps.hour = 0
            firstComps.minute = 0
            firstComps.second = 0
            secondComps.hour = 0
            secondComps.minute = 0
            secondComps.second = 0

        case .timeOnly:
            firstComps.year = 1
            firstComps.month = 1
            firstComps.day = 1
            secondComps.year = 1
            secondComps.month = 1
            secondComps.day = 1

        default: break
        }

        guard let first = self.calendar.date(from: firstComps) else { throw ComparisonError.conversionError(self.firstDate) }
        guard let second = self.calendar.date(from: secondComps) else { throw ComparisonError.conversionError(self.secondDate) }

        let components : Set<Calendar.Component>
        switch mode {
        case .dateOnly:
            components = [ .year, .month, .day ]

        case .timeOnly:
            components = [ .hour, .minute, .second ]

        case .dateAndTime:
            components = [ .year, .month, .day, .hour, .minute, .second ]
        }

        return calendar.dateComponents(components, from: first, to: second)
    }

}


enum ComparisonError : Error {
    case conversionError(DateFields)
}
