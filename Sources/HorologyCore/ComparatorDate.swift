//
//  ComparatorDate.swift
//  Horology
//
//  Created by Paul Schifferer on 24/8/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


/**
 A value object used to represent date information for the comparator that the user wishes to maintain, for example,
 in persisted storage.
 */
struct ComparatorDate {
    var calendarId : String
    var fromYear : Int
    var fromMonth : Int
    var fromDay : Int
    var fromHour : Int
    var fromMinute : Int
    var fromSecond : Int
    var toYear : Int
    var toMonth : Int
    var toDay : Int
    var toHour : Int
    var toMinute : Int
    var toSecond : Int

    init() {
        let calendar = Calendar.autoupdatingCurrent
        calendarId = calendar.asString()
        let comps = calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: Date())
        fromYear = comps.year ?? 2017
        fromMonth = comps.month ?? 0
        fromDay = comps.day ?? 1
        fromHour = comps.hour ?? 0
        fromMinute = comps.minute ?? 0
        fromSecond = comps.second ?? 0
        toYear = comps.year ?? 2017
        toMonth = comps.month ?? 0
        toDay = comps.day ?? 1
        toHour = comps.hour ?? 0
        toMinute = comps.minute ?? 0
        toSecond = comps.second ?? 0
    }

}
