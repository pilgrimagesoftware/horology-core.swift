//
//  DateWorker.swift
//  Horology
//
//  Created by Paul Schifferer on 24/8/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


/**
 Initialize an instance of this class to calculate a new date from a starting date and a set of adjustments.
 Set the date and the adjustments and then call `calculateDate(with:)` to get the result.
 */
class DateCalculator {

    var startDate : DateFields = DateFields()
    var adjustments : DateFields = DateFields()
    var calendar : Calendar = Calendar.autoupdatingCurrent

    /**
     Perform a date calculation with the
 */
    func calculateDate(with mode : DateTimeMode) throws -> Date {
        // validate the first date
        try DateFieldsValidator(fields: self.startDate).validate(using: mode, calendar: self.calendar)

        var baseComps = DateComponents.from(fields: self.startDate)

        var actualAdjustments = DateComponents()
        switch mode {
        case .dateOnly:
            //            components = [ .year, .month, .day ]
            actualAdjustments.year = adjustments.year?.value ?? 0
            actualAdjustments.month = adjustments.month?.value ?? 0
            actualAdjustments.day = adjustments.day?.value ?? 0
            actualAdjustments.hour = 0
            actualAdjustments.minute = 0
            actualAdjustments.second = 0
            baseComps.hour = 0
            baseComps.minute = 0
            baseComps.second = 0

        case .timeOnly:
            //            components = [ .hour, .minute, .second ]
            actualAdjustments.hour = adjustments.hour?.value ?? 0
            actualAdjustments.minute = adjustments.minute?.value ?? 0
            actualAdjustments.second = adjustments.second?.value ?? 0
            actualAdjustments.year = 0
            actualAdjustments.month = 0
            actualAdjustments.day = 0
            baseComps.year = 0
            baseComps.month = 0
            baseComps.day = 0

        case .dateAndTime:
            //            components = [ .year, .month, .day, .hour, .minute, .second ]
            actualAdjustments.year = adjustments.year?.value ?? 0
            actualAdjustments.month = adjustments.month?.value ?? 0
            actualAdjustments.day = adjustments.day?.value ?? 0
            actualAdjustments.hour = adjustments.hour?.value ?? 0
            actualAdjustments.minute = adjustments.minute?.value ?? 0
            actualAdjustments.second = adjustments.second?.value ?? 0
        }

        guard let baseDate = self.calendar.date(from: baseComps) else { throw CalculationError.conversionError(self.startDate) }

        return calendar.date(byAdding: actualAdjustments, to: baseDate) ?? baseDate
    }

}


enum CalculationError : Error {
    case conversionError(DateFields)
}
