//
//  CommonFunctions.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


/**
 * Adjusts the date fields by the given adjustment value.
 */
func handleAdjustment(by adjustment : Int, on field : DateTimeFieldType?, with fields : DateFields) -> DateFields? {
    guard let field = field else { return nil }

    //        var components = self.calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: date)
    var modifiedComponents = fields

    switch field {
    case .year:
        if var v = fields.year?.value {
            v += adjustment
            modifiedComponents.year?.value = v
        }
        else {
            modifiedComponents.year = DateTimeField(type: .year, value: adjustment)
        }

    case .month:
        if var v = fields.month?.value {
            v += adjustment
            modifiedComponents.month?.value = v
        }
        else {
            modifiedComponents.month = DateTimeField(type: .month, value: adjustment)
        }

    case .day:
        if var v = fields.day?.value {
            v += adjustment
            modifiedComponents.day?.value = v
        }
        else {
            modifiedComponents.day = DateTimeField(type: .day, value: adjustment)
        }

    case .hour:
        if var v = fields.hour?.value {
            v += adjustment
            modifiedComponents.hour?.value = v
        }
        else {
            modifiedComponents.hour = DateTimeField(type: .hour, value: adjustment)
        }

    case .minute:
        if var v = fields.minute?.value {
            v += adjustment
            modifiedComponents.minute?.value = v
        }
        else {
            modifiedComponents.minute = DateTimeField(type: .minute, value: adjustment)
        }

    case .second:
        if var v = fields.second?.value {
            v += adjustment
            modifiedComponents.second?.value = v
        }
        else {
            modifiedComponents.second = DateTimeField(type: .second, value: adjustment)
        }
    }

    return modifiedComponents
}

func handleValue(_ value : Int, on field : DateTimeFieldType?, with fields : DateFields) -> DateFields? {
    guard let field = field else { return nil }

    //        var components = self.calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: date)
    var modifiedFields = fields

    switch field {
    case .year:
        var v = modifiedFields.year ?? DateTimeField(type: .year, value: value)
        v.value = value
        modifiedFields.year = v

    case .month:
        var v = modifiedFields.month ?? DateTimeField(type: .month, value: value)
        v.value = value
        modifiedFields.month = v

    case .day:
        var v = modifiedFields.day ?? DateTimeField(type: .day, value: value)
        v.value = value
        modifiedFields.day = v

    case .hour:
        var v = modifiedFields.hour ?? DateTimeField(type: .hour, value: value)
        v.value = value
        modifiedFields.hour = v

    case .minute:
        var v = modifiedFields.minute ?? DateTimeField(type: .minute, value: value)
        v.value = value
        modifiedFields.minute = v

    case .second:
        var v = modifiedFields.second ?? DateTimeField(type: .second, value: value)
        v.value = value
        modifiedFields.second = v
    }

    return modifiedFields
}

func currentValue(in field : DateTimeFieldType?, with fields : DateFields) -> Int? {
    guard let field = field else { return nil }

    //        let components = self.calendar.dateComponents([ .year, .month, .day, .hour, .minute, .second ], from: date)

    switch field {
    case .year:
        if let v = fields.year {
            return v.value
        }

    case .month:
        if let v = fields.month {
            return v.value
        }

    case .day:
        if let v = fields.day {
            return v.value
        }

    case .hour:
        if let v = fields.hour {
            return v.value
        }

    case .minute:
        if let v = fields.minute {
            return v.value
        }

    case .second:
        if let v = fields.second {
            return v.value
        }
    }

    return nil
}
