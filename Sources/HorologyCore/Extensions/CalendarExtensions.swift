//
//  CalendarExtensions.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation

extension Calendar {

    public static var identifiers: [Calendar.Identifier] {
        return [
            .buddhist, .chinese, .coptic, .ethiopicAmeteAlem, .ethiopicAmeteMihret, .gregorian,
            .hebrew, .indian,
            .islamic, .islamicCivil, .islamicTabular, .islamicUmmAlQura, .iso8601, .japanese,
            .persian, .republicOfChina,
        ]
    }

    public static func from(identifier: String) throws -> Calendar {
        guard let id = calendarIds[identifier] else {
            throw HorologyError.invalidCalendarIdentifier(identifier)
        }

        return Calendar(identifier: id)
    }

    public func asString() -> String {
        return "\(identifier)"
    }

    public var label: String {
        return NSLocalizedString("calendar.identifier.\(self.identifier)", comment: "")
    }

}
