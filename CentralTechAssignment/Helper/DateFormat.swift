//
//  DateFormat.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 8/1/2564 BE.
//

import Foundation

public enum DateFormat: String {
    case Display = "dd MMM yyyy"
    case DisplayFullMonth = "dd MMMM yyyy"
    case DisplayFullMonthWithoutPrefix = "d MMMM yyyy"
    case DisplayDateTime = "dd MMM yyyy HH:mm a"
    case DisplayDateTime24hour = "dd MMM yyyy HH:mm:ss"
    case Short = "yyyy-MM-dd"
    case Medium = "yyyy-M-dd'T'HH:mm:ss.SSS"
    case Full = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case Data = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    case DisplayDateForSlip = "dd-MMMM-yyyy (HH:mm)"
    case DisplayDateDayOnly = "EEEE"
    case DisplayDateNumberOfDayOnly = "dd"
    case DateTimeZone = "yyyy-MM-ddZ"
    case FullDateTimeZone = "yyyy-MM-dd'T'HH:mm:ssZ"
    case UpdatedNewsDate = "MMM dd, HH:mm"
}

public enum LocaleFormat: String {
    case Th = "th_TH"
    case En = "en_US_POSIX"
}

extension String {
    public func formattedDate(format: DateFormat, locale: LocaleFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: locale.rawValue)
        formatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
        let date = formatter.date(from: self)
        if date == nil {
            return Date()
        }
        return date
    }
}

extension Date {
    public func formattedDateString(format: DateFormat, locale: LocaleFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: locale.rawValue)
        formatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
        return formatter.string(from: self)
    }
}
