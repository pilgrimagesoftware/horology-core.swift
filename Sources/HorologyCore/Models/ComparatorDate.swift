//
//  ComparatorDate.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


/**
 A value object used to represent date information for the comparator that the user wishes to maintain, for example,
 in persisted storage.
 */
public struct ComparatorDate {
    public var calendarId : String
    public var fromYear : Int
    public var fromMonth : Int
    public var fromDay : Int
    public var fromHour : Int
    public var fromMinute : Int
    public var fromSecond : Int
    public var toYear : Int
    public var toMonth : Int
    public var toDay : Int
    public var toHour : Int
    public var toMinute : Int
    public var toSecond : Int

    public init() {
        let calendar = Calendar.autoupdatingCurrent
        calendarId = calendar.asString()
        let comps = calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: Date())
        fromYear = comps.year ?? 2025
        fromMonth = comps.month ?? 0
        fromDay = comps.day ?? 1
        fromHour = comps.hour ?? 0
        fromMinute = comps.minute ?? 0
        fromSecond = comps.second ?? 0
        toYear = comps.year ?? 2025
        toMonth = comps.month ?? 0
        toDay = comps.day ?? 1
        toHour = comps.hour ?? 0
        toMinute = comps.minute ?? 0
        toSecond = comps.second ?? 0
    }

}
