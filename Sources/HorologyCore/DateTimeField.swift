//
//  DateTimeField.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


public enum DateTimeFieldType : String, Sendable {
    case year
    case month
    case day
    case hour
    case minute
    case second

    public func calendarComponent() -> Calendar.Component {
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

public enum FieldValidity {
    case valid
    case outOfRange
    case noValue
    case invalidValue
}

public struct DateTimeField {
    public var type : DateTimeFieldType
    public var value : Int
    public var validity : FieldValidity

    public init(type : DateTimeFieldType, value : Int) {
        self.type = type
        self.value = value
        self.validity = .valid
    }
}
