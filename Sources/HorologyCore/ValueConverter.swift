//
//  ValueConverter.swift
//  Horology
//
//  Created by Paul Schifferer on 26/8/17.
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


class ValueConverter {

    private var calendar : Calendar = Calendar.autoupdatingCurrent
    private var converters : [ConversionValueType : () -> ConvertedValue] = [:]

    var value : Int = 0
    var valueType : ConversionValueType = .years

    init() {
        converters[.years] = convertToYears
        converters[.months] = convertToMonths
        converters[.weeks] = convertToWeeks
        converters[.days] = convertToDays
        converters[.hours] = convertToHours
        converters[.minutes] = convertToMinutes
        converters[.seconds] = convertToSeconds
        converters[.dogYears] = convertToDogYears
        converters[.catYears] = convertToCatYears
    }

    func convert(to : ConversionValueType) -> ConvertedValue {
        return converters[to]?() ?? ConvertedValue(value: nil, approximate: false)
    }

    private func convertToYears() -> ConvertedValue {
        guard valueType != .years else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeeks = (calendar.maximumRange(of: .weekOfYear)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .months:
            let v = value / maxMonths
            return ConvertedValue(value: v, approximate: false)

        case .weeks:
            let v = value / maxWeeks
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = value / (maxMonths * maxDays)
            return ConvertedValue(value: v, approximate: true)

        case .hours:
            let v = value / (maxMonths * maxDays * maxHours)
            return ConvertedValue(value: v, approximate: true)

        case .minutes:
            let v = value / (maxMonths * maxDays * maxHours * maxMinutes)
            return ConvertedValue(value: v, approximate: true)

        case .seconds:
            let v = value / (maxMonths * maxDays * maxHours * maxMinutes * maxSeconds)
            return ConvertedValue(value: v, approximate: true)

        case .dogYears:
            let v : Int
            if value > 2 {
                v = 21 + (value - 2) * 4
            }
            else {
                v = Int(Double(value) * 10.5)
            }
            return ConvertedValue(value: v, approximate: true)

        case .catYears:
            let v : Int
            var a : Bool = true
            if value > 14 {
                v = 72 + (value - 14) * 2
            }
            else if value > 2 {
                v = 24 + (value - 2) * 4
            }
            else if value > 1 {
                v = 24
            }
            else if value > 0 {
                v = 15
            }
            else {
                v = 0
                a = false
            }
            return ConvertedValue(value: v, approximate: a)

        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToMonths() -> ConvertedValue {
        guard valueType != .months else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeeks = (calendar.maximumRange(of: .weekOfYear)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * maxMonths
            return ConvertedValue(value: v, approximate: false)

        case .weeks:
            let v = value / (maxWeeks / maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = value / maxDays
            return ConvertedValue(value: v, approximate: true)

        case .hours:
            let v = value / (maxDays * maxHours)
            return ConvertedValue(value: v, approximate: true)

        case .minutes:
            let v = value / (maxDays * maxHours * maxMinutes)
            return ConvertedValue(value: v, approximate: true)

        case .seconds:
            let v = value / (maxDays * maxHours * maxMinutes * maxSeconds)
            return ConvertedValue(value: v, approximate: true)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToWeeks() -> ConvertedValue {
        guard valueType != .weeks else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeeks = (calendar.maximumRange(of: .weekOfYear)?.upperBound ?? 1) - 1
        let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * maxWeeks
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = value * (maxWeeks / maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = value / maxWeekdays
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = value / maxHours / maxWeekdays
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = value / (maxHours * maxMinutes) / maxWeekdays
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = value / (maxHours * maxMinutes * maxSeconds) / maxWeekdays
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToDays() -> ConvertedValue {
        guard valueType != .days else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * (maxDays * maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = value * maxDays
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = value * maxWeekdays
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = value / maxHours
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = value / (maxHours * maxMinutes)
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = value / (maxHours * maxMinutes * maxSeconds)
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToHours() -> ConvertedValue {
        guard valueType != .hours else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * (maxHours * maxDays * maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = value * (maxHours * maxDays)
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = value * maxWeekdays * maxHours
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v = value * maxHours
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = value / maxMinutes
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = value / (maxMinutes * maxSeconds)
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToMinutes() -> ConvertedValue {
        guard valueType != .minutes else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * (maxMinutes * maxHours * maxDays * maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = value * (maxMinutes * maxHours * maxDays)
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = value * maxWeekdays * maxHours * maxMinutes
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v = value * maxMinutes * maxHours
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = value * maxMinutes
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = value / maxSeconds
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToSeconds() -> ConvertedValue {
        guard valueType != .seconds else { return ConvertedValue(value: nil, approximate: false) }

        let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1) - 1
        let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1) - 1
        let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1) - 1

        switch valueType {
        case .years:
            let v = value * (maxSeconds * maxMinutes * maxHours * maxDays * maxMonths)
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = value * (maxSeconds * maxMinutes * maxHours * maxDays)
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = value * maxWeekdays * maxHours * maxMinutes * maxSeconds
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v = value * maxSeconds * maxMinutes * maxHours
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = value * maxSeconds * maxMinutes
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = value * maxSeconds
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToDogYears() -> ConvertedValue {
        guard valueType != .dogYears else { return ConvertedValue(value: nil, approximate: false) }

        switch valueType {

        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

    private func convertToCatYears() -> ConvertedValue {
        guard valueType != .catYears else { return ConvertedValue(value: nil, approximate: false) }

        switch valueType {

        default:
            return ConvertedValue(value: nil, approximate: false)
        }
    }

}

struct ConvertedValue {
    var value : Int?
    var approximate : Bool
}

enum ConversionValueType : String {
    case years = "years"
    case months = "months"
    case weeks = "weeks"
    case days = "days"
    case hours = "hours"
    case minutes = "minutes"
    case seconds = "seconds"
    case milliseconds = "milliseconds"
    case catYears = "cat-years"
    case dogYears = "dog-years"
}
