//
//  DateFields.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct DateFields {
    public var year : DateTimeField?
    public var month : DateTimeField?
    public var day : DateTimeField?
    public var hour : DateTimeField?
    public var minute : DateTimeField?
    public var second : DateTimeField?
}


extension DateFields : Sendable {}


public extension DateFields {

    init(components : DateComponents) {
        if let v = components.year {
            self.year = DateTimeField(type: .year, value: v)
        }
        if let v = components.month {
            self.month = DateTimeField(type: .month, value: v)
        }
        if let v = components.day {
            self.day = DateTimeField(type: .day, value: v)
        }
        if let v = components.hour {
            self.hour = DateTimeField(type: .hour, value: v)
        }
        if let v = components.minute {
            self.minute = DateTimeField(type: .minute, value: v)
        }
        if let v = components.second {
            self.second = DateTimeField(type: .second, value: v)
        }
    }

    init(fields : [DateTimeField]) {
        fields.forEach { (f) in
            switch f.type {
            case .year:
                self.year = f

            case .month:
                self.month = f

            case .day:
                self.day = f

            case .hour:
                self.hour = f

            case .minute:
                self.minute = f

            case .second:
                self.second = f
            }
        }
    }

    func date(using calendar : Calendar) -> Date? {
        let comps = DateComponents.from(fields: self)
        return calendar.date(from: comps)
    }

    func asComponents() -> DateComponents {
        var comps = DateComponents()

        comps.year = year?.value
        comps.month = month?.value
        comps.day = day?.value
        comps.hour = hour?.value
        comps.minute = minute?.value
        comps.second = second?.value

        return comps
    }

    func asFields() -> [DateTimeField] {
        return [ self.year, self.month, self.day,
                 self.hour, self.minute, self.second ].compactMap({ $0 })
    }

}
