//
//  Constants.swift
//  Horology Core
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//


public enum DateTimeMode : String {
    case dateOnly
    case timeOnly
    case dateAndTime
}

public enum HorologyError : Error {
    case invalidCalendarIdentifier(String)
}
