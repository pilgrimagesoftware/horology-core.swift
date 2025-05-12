//
//  DateTimeField.swift
//  Horology
//
//  Created by Paul Schifferer on 8/9/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


enum DateTimeFieldType : String {
    case year
    case month
    case day
    case hour
    case minute
    case second

    func calendarComponent() -> Calendar.Component {
        switch self {
        case .year:
            return .year

        case .month:
            return .month

        case .day:
            return .day

        case .hour:
            return .hour

        case .minute:
            return .minute

        case .second:
            return .second
        }
    }
}

enum FieldValidity {
    case valid
    case outOfRange
    case noValue
    case invalidValue
}

struct DateTimeField {
    var type : DateTimeFieldType
    var value : Int
    var validity : FieldValidity

    init(type : DateTimeFieldType, value : Int) {
        self.type = type
        self.value = value
        self.validity = .valid
    }
}
