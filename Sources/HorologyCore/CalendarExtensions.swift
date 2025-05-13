//
//  CalendarExtensions.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


extension Calendar {

    static var identifiers : [Calendar.Identifier] {
        return [
            .buddhist, .chinese, .coptic, .ethiopicAmeteAlem, .ethiopicAmeteMihret, .gregorian, .hebrew, .indian,
            .islamic, .islamicCivil, .islamicTabular, .islamicUmmAlQura, .iso8601, .japanese, .persian, .republicOfChina
        ]
    }

    static func from(identifier : String) -> Calendar {
        switch identifier {
        case "buddhist":
            return Calendar(identifier: .buddhist)

        case "chinese":
            return Calendar(identifier: .chinese)

        case "coptic":
            return Calendar(identifier: .coptic)

        case "ethiopicAmeteAlem":
            return Calendar(identifier: .ethiopicAmeteAlem)

        case "ethiopicAmeteMihret":
            return Calendar(identifier: .ethiopicAmeteMihret)

        case "gregorian":
            return Calendar(identifier: .gregorian)

        case "hebrew":
            return Calendar(identifier: .hebrew)

        case "indian":
            return Calendar(identifier: .indian)

        case "islamic":
            return Calendar(identifier: .islamic)

        case "islamicCivil":
            return Calendar(identifier: .islamicCivil)

        case "islamicTabular":
            return Calendar(identifier: .islamicTabular)

        case "islamicUmmAlQura":
            return Calendar(identifier: .islamicUmmAlQura)

        case "iso8601":
            return Calendar(identifier: .iso8601)

        case "japanese":
            return Calendar(identifier: .japanese)

        case "persian":
            return Calendar(identifier: .persian)

        case "republicOfChina":
            return Calendar(identifier: .republicOfChina)

        default: break
        }

        return Calendar.autoupdatingCurrent
    }

    func asString() -> String {
        return "\(identifier)"
    }

    var label : String {
        return NSLocalizedString("calendar.identifier.\(self.identifier)", comment: "")
    }

}
