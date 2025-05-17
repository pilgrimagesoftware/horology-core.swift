//
//  ValueConverter.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import Logging

let logger = Logger(label: "com.pilgrimagesoftware.horology.core.ValueConverter")

public class ValueConverter {

    private var calendar: Calendar = Calendar.autoupdatingCurrent
    private var converters: [ConversionValueType: () throws -> ConvertedValue] = [:]
    // private var maxValues: [ConversionValueType: Int] = [:]

    public var value: Int = 0
    public var valueType: ConversionValueType = .years

    public init() throws {
        converters[.years] = convertToYears
        converters[.months] = convertToMonths
        converters[.weeks] = convertToWeeks
        converters[.days] = convertToDays
        converters[.hours] = convertToHours
        converters[.minutes] = convertToMinutes
        converters[.seconds] = convertToSeconds
        converters[.dogYears] = convertToDogYears
        converters[.catYears] = convertToCatYears

        // maxValues[.months] = try getRangeValue(for: .month)
        // maxValues[.weeks] = try getRangeValue(for: .weekOfYear)
        // maxValues[.days] = try getRangeValue(for: .day)
        // maxValues[.hours] = try getRangeValue(for: .hour)
        // maxValues[.minutes] = try getRangeValue(for: .minute)
        // maxValues[.seconds] = try getRangeValue(for: .second)
        // maxValues[] = try getRangeValue(for: .yearForWeekOfYear)

        // debugPrint("maxValues: \(maxValues)")

        let comps: [Calendar.Component] = [
            .era, .year, .month, .day, .hour, .minute, .second, .weekday,
            .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond,
            // .calendar,
            // .timeZone,
            // .isLeapMonth,
            // .dayOfYear,
        ]

        for comp in comps {
            let compValue = try getRangeValue(for: comp)
            debugPrint("comp (\(comp)): \(compValue)")
        }

    }

    public convenience init(value: Int, valueType: ConversionValueType) throws {
        try self.init()
        self.value = value
        self.valueType = valueType
    }

    public func convert(to: ConversionValueType) throws -> ConvertedValue {
        guard let converter = converters[to] else {
            throw ConversionError.unknownConversion(to)
        }

        return try converter()
    }

    private func convertToYears() throws -> ConvertedValue {
        guard valueType != .years else { throw ConversionError.invalidValueType(valueType) }

        switch valueType {
        case .months:
            let months = try getRangeValue(for: .month)
            let v = value / months
            return ConvertedValue(value: v, approximate: months > value)

        case .weeks:
            let v = try (value / getRangeValue(for: .weekOfYear))
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = try (value / (getRangeValue(for: .month) * getRangeValue(for: .day)))
            return ConvertedValue(value: v, approximate: true)

        case .hours:
            let v =
                try
                (value
                / (getRangeValue(for: .month) * getRangeValue(for: .day)
                    * getRangeValue(for: .hour)))
            return ConvertedValue(value: v, approximate: true)

        case .minutes:
            let v =
                try
                (value
                / (getRangeValue(for: .month) * getRangeValue(for: .day)
                    * getRangeValue(for: .hour) * getRangeValue(for: .minute)))
            return ConvertedValue(value: v, approximate: true)

        case .seconds:
            let v =
                try
                (value
                / (getRangeValue(for: .month) * getRangeValue(for: .day)
                    * getRangeValue(for: .hour) * getRangeValue(for: .minute)
                    * getRangeValue(for: .second)))
            return ConvertedValue(value: v, approximate: true)

        case .dogYears:
            let v: Int
            if value > 2 {
                v = 21 + (value - 2) * 4
            } else {
                v = Int(Double(value) * 10.5)
            }
            return ConvertedValue(value: v, approximate: true)

        case .catYears:
            let v: Int
            var a: Bool = true
            if value > 14 {
                v = 72 + (value - 14) * 2
            } else if value > 2 {
                v = 24 + (value - 2) * 4
            } else if value > 1 {
                v = 24
            } else if value > 0 {
                v = 15
            } else {
                v = 0
                a = false
            }
            return ConvertedValue(value: v, approximate: a)

        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToMonths() throws -> ConvertedValue {
        guard valueType != .months else { throw ConversionError.invalidValueType(valueType) }

        // let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        // let maxWeeks = (calendar.maximumRange(of: .weekOfYear)?.upperBound ?? 1)
        // let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        // let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1)
        // let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1)
        // let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1)

        switch valueType {
        case .years:
            let v = try (value * getRangeValue(for: .month))
            return ConvertedValue(value: v, approximate: false)

        case .weeks:
            let v = try (value / getRangeValue(for: .weekOfMonth))
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = try (value / getRangeValue(for: .day))
            return ConvertedValue(value: v, approximate: true)

        case .hours:
            let v = try (value / (getRangeValue(for: .day) * getRangeValue(for: .hour)))
            return ConvertedValue(value: v, approximate: true)

        case .minutes:
            let v =
                try
                (value
                / (getRangeValue(for: .day) * getRangeValue(for: .hour)
                    * getRangeValue(for: .minute)))
            return ConvertedValue(value: v, approximate: true)

        case .seconds:
            let v =
                try
                (value
                / (getRangeValue(for: .day) * getRangeValue(for: .hour)
                    * getRangeValue(for: .minute) * getRangeValue(for: .second)))
            return ConvertedValue(value: v, approximate: true)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToWeeks() throws -> ConvertedValue {
        guard valueType != .weeks else { throw ConversionError.invalidValueType(valueType) }

        // let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        // let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        // let maxWeeks = (calendar.maximumRange(of: .weekOfYear)?.upperBound ?? 1) - 1
        // let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1)
        // let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1)
        // let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1)

        switch valueType {
        case .years:
            let v = try (value * getRangeValue(for: .weekOfYear))
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = try (value * (getRangeValue(for: .weekOfYear) / getRangeValue(for: .month)))
            return ConvertedValue(value: v, approximate: true)

        case .days:
            let v = try (value / getRangeValue(for: .weekday))
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = try (value / (getRangeValue(for: .hour) * getRangeValue(for: .weekday)))
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v =
                try
                (value / (getRangeValue(for: .hour) * getRangeValue(for: .minute))
                / getRangeValue(for: .weekday))
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v =
                try
                (value
                / (getRangeValue(for: .hour) * getRangeValue(for: .minute)
                    * getRangeValue(for: .second)) / getRangeValue(for: .weekday))
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToDays() throws -> ConvertedValue {
        guard valueType != .days else { throw ConversionError.invalidValueType(valueType) }

        // let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        // let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        // let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1) - 1
        // let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1)
        // let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1)
        // let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1)

        switch valueType {
        case .years:
            let v = try (value * (getRangeValue(for: .day) * getRangeValue(for: .month)))
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = try (value * getRangeValue(for: .day))
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = try (value * getRangeValue(for: .weekday))
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = try (value / getRangeValue(for: .hour))
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = try (value / (getRangeValue(for: .hour) * getRangeValue(for: .minute)))
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v =
                try
                (value
                / (getRangeValue(for: .hour) * getRangeValue(for: .minute)
                    * getRangeValue(for: .second)))
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToHours() throws -> ConvertedValue {
        guard valueType != .hours else { throw ConversionError.invalidValueType(valueType) }

        // let maxMonths = (calendar.maximumRange(of: .month)?.upperBound ?? 1) - 1
        // let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        // let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1)
        // let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1)
        // let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1)
        // let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1)

        switch valueType {
        case .years:
            let v =
                try
                (value
                * (getRangeValue(for: .hour) * getRangeValue(for: .day) * getRangeValue(for: .month)))
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v = try (value * (getRangeValue(for: .hour) * getRangeValue(for: .day)))
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v = try (value * (getRangeValue(for: .weekday) * getRangeValue(for: .hour)))
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v = try (value * getRangeValue(for: .hour))
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = try (value / getRangeValue(for: .minute))
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = try (value / (getRangeValue(for: .minute) * getRangeValue(for: .second)))
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToMinutes() throws -> ConvertedValue {
        guard valueType != .minutes else { throw ConversionError.invalidValueType(valueType) }

        // guard let monthRange = calendar.maximumRange(of: .month) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("monthRange: \(monthRange)")
        // guard let weekdayRange = calendar.maximumRange(of: .weekday) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("weekdayRange: \(weekdayRange)")
        // guard let dayRange = calendar.maximumRange(of: .day) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("dayRange: \(dayRange)")
        // guard let hourRange = calendar.maximumRange(of: .hour) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("hourRange: \(hourRange)")
        // guard let minuteRange = calendar.maximumRange(of: .minute) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("minuteRange: \(minuteRange)")
        // guard let secondRange = calendar.maximumRange(of: .second) else {
        //     throw ConversionError.invalidValueType(valueType)
        // }
        // debugPrint("secondRange: \(secondRange)")

        // // let minMonths = (calendar.minimumRange(of: .month)?.upperBound ?? 1) - 1 // + (calendar.maximumRange(of: .month)?.lowerBound ?? 1)) / 2
        // // debugPrint("minMonths: \(minMonths)")
        // let maxMonths = try getRangeValue(for: .month)
        // debugPrint("maxMonths: \(maxMonths)")
        // let maxWeekdays = (calendar.maximumRange(of: .weekday)?.upperBound ?? 1) - 1
        // let maxDays = (calendar.maximumRange(of: .day)?.upperBound ?? 1)
        // let maxHours = (calendar.maximumRange(of: .hour)?.upperBound ?? 1)
        // let maxMinutes = (calendar.maximumRange(of: .minute)?.upperBound ?? 1)
        // let maxSeconds = (calendar.maximumRange(of: .second)?.upperBound ?? 1)

        switch valueType {
        case .years:
            let v =
                try
                (value * getRangeValue(for: .minute) * getRangeValue(for: .hour)
                * getRangeValue(for: .day) * getRangeValue(for: .month))
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v =
                try
                (value * getRangeValue(for: .minute) * getRangeValue(for: .hour)
                * getRangeValue(for: .day))
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v =
                try
                (value * getRangeValue(for: .weekday) * getRangeValue(for: .hour)
                * getRangeValue(for: .minute))
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v = try (value * getRangeValue(for: .minute) * getRangeValue(for: .hour))
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = try (value * getRangeValue(for: .minute))
            return ConvertedValue(value: v, approximate: false)

        case .seconds:
            let v = try (value / getRangeValue(for: .second))
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToSeconds() throws -> ConvertedValue {
        guard valueType != .seconds else { throw ConversionError.invalidValueType(valueType) }

        // let maxMonths = try getRangeValue(for: .month)
        // debugPrint("maxMonths: \(maxMonths)")
        // let maxWeekdays = try getRangeValue(for: .weekday)
        // debugPrint("maxWeekdays: \(maxWeekdays)")
        // let maxDays = try getRangeValue(for: .day)
        // debugPrint("maxDays: \(maxDays)")
        // let maxHours = try getRangeValue(for: .hour)
        // debugPrint("maxHours: \(maxHours)")
        // let maxMinutes = try getRangeValue(for: .minute)
        // debugPrint("maxMinutes: \(maxMinutes)")
        // let maxSeconds = try getRangeValue(for: .second)
        // debugPrint("maxSeconds: \(maxSeconds)")

        switch valueType {
        case .years:
            let v =
                try
                (value * getRangeValue(for: .second) * getRangeValue(for: .minute)
                * getRangeValue(for: .hour) * getRangeValue(for: .day) * getRangeValue(for: .month))
            return ConvertedValue(value: v, approximate: true)

        case .months:
            let v =
                try
                (value * getRangeValue(for: .second) * getRangeValue(for: .minute)
                * getRangeValue(for: .hour) * getRangeValue(for: .day))
            return ConvertedValue(value: v, approximate: true)

        case .weeks:
            let v =
                try
                (value * getRangeValue(for: .weekday) * getRangeValue(for: .hour)
                * getRangeValue(for: .minute) * getRangeValue(for: .second))
            return ConvertedValue(value: v, approximate: false)

        case .days:
            let v =
                try
                (value * getRangeValue(for: .second) * getRangeValue(for: .minute)
                * getRangeValue(for: .hour))
            return ConvertedValue(value: v, approximate: false)

        case .hours:
            let v = try (value * getRangeValue(for: .second) * getRangeValue(for: .minute))
            return ConvertedValue(value: v, approximate: false)

        case .minutes:
            let v = try (value * getRangeValue(for: .second))
            return ConvertedValue(value: v, approximate: false)

        case .dogYears, .catYears:
            fallthrough
        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToDogYears() throws -> ConvertedValue {
        guard valueType != .dogYears else { throw ConversionError.invalidValueType(valueType) }

        switch valueType {

        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func convertToCatYears() throws -> ConvertedValue {
        guard valueType != .catYears else { throw ConversionError.invalidValueType(valueType) }

        switch valueType {

        default:
            throw ConversionError.invalidValueType(valueType)
        }
    }

    private func getRangeValue(for component: Calendar.Component) throws -> Int {
        // debugPrint("getRangeValue for \(component)")
        guard let range = calendar.maximumRange(of: component) else {
            throw ConversionError.unknownComponent(component)
        }

        // debugPrint("range: \(range)")
        let value = range.upperBound - range.lowerBound
        // debugPrint("value: \(value)")
        return value
    }
}

public enum ConversionError: Error {
    case invalidValueType(ConversionValueType)
    case unknownConversion(ConversionValueType)
    case unknownComponent(Calendar.Component)
}

public struct ConvertedValue {
    public var value: Int
    public var approximate: Bool
}

public enum ConversionValueType: String {
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
