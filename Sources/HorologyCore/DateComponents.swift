//
//  DateComponents.swift
//  Horology
//
//  Created by Paul Schifferer on 18/9/17.
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation


extension DateComponents {

    static func from(fields : DateFields) -> DateComponents {

        var comps = DateComponents()

        comps.year = fields.year?.value
        comps.month = fields.month?.value
        comps.day = fields.day?.value
        comps.hour = fields.hour?.value
        comps.minute = fields.minute?.value
        comps.second = fields.second?.value

        return comps
    }
}
