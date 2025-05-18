//
//  Constants.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation

public enum DateTimeMode: String {
    case dateOnly
    case timeOnly
    case dateAndTime
}

public enum HorologyError: Error {
    case invalidCalendarIdentifier(String)
}

public let calendarIds: [String: Calendar.Identifier] = [
    "buddhist": .buddhist,
    "chinese": .chinese,
    "coptic": .coptic,
    "ethiopicAmeteAlem": .ethiopicAmeteAlem,
    "ethiopicAmeteMihret": .ethiopicAmeteMihret,
    "gregorian": .gregorian,
    "hebrew": .hebrew,
    "indian": .indian,
    "islamic": .islamic,
    "islamicCivil": .islamicCivil,
    "islamicTabular": .islamicTabular,
    "islamicUmmAlQura": .islamicUmmAlQura,
    "iso8601": .iso8601,
    "japanese": .japanese,
    "persian": .persian,
    "republicOfChina": .republicOfChina,
]
