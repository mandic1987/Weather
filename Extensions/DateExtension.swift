//
//  DateExtension.swift
//  Weather
//
//  Created by iOS on 1/26/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import Foundation
import Marshal

extension Date : ValueType {
    public static func value(from object: Any) throws -> Date {
        switch object {
        case let date as Date:
            return date
            
        case let dateString as String:
            if let date = DateFormatter.iso8601Formatter.date(from: dateString) {
                return date
            } else if let date = DateFormatter.iso8601FractionalSecondsFormatter.date(from: dateString) {
                return date
            } else if let date = DateFormatter.iso8601NoTimeZoneFormatter.date(from: dateString) {
                return date
            }
            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
            
        case let dateNum as Int64:
            return Date(timeIntervalSince1970: TimeInterval(integerLiteral: dateNum) )
            
        case let dateNum as Double:
            return Date(timeIntervalSince1970: dateNum)
            
        default:
            throw MarshalError.typeMismatch(expected: "Date", actual: type(of: object))
        }
    }
}

extension DateFormatter {
    static let iso8601Formatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df
    }()
    
    static let iso8601NoTimeZoneFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return df
    }()
    
    static let iso8601FractionalSecondsFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df
    }()
}
