//
//  DateExtensions.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


extension Date {

    func convert(fromCalendar : Calendar, toCalendar : Calendar) -> Date? {
        let originalComps = fromCalendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: self)
        return toCalendar.date(from: originalComps)
    }

}
