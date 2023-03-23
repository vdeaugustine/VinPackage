//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

/// Get business days
extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

extension Date {
    /// A Boolean value indicating whether the date is on a weekend day (Saturday or Sunday) using the ISO 8601 calendar.
    public var isDateInWeekend: Bool {
        return Calendar.iso8601.isDateInWeekend(self)
    }

    /// Returns the date that represents tomorrow at noon (12:00 PM).
    public var tomorrow: Date {
        return Calendar.iso8601.date(byAdding: .day,
                                     value: 1,
                                     to: noon)!
    }

    /// Returns the date at noon (12:00 PM) for the current date.
    public var noon: Date {
        return Calendar.iso8601.date(bySettingHour: 12,
                                     minute: 0,
                                     second: 0,
                                     of: self)!
    }

    /// Returns the time interval between two dates by subtracting the time interval of one date from another.
    static public func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    // MARK: - Properties

    /// A constant representing 9:00 AM on the current day.
    static let nineAM: Date = Date.getThisTime(hour: 9, minute: 0)!

    /// A constant representing 5:00 PM on the current day.
    static let fivePM: Date = Date.getThisTime(hour: 17, minute: 0)!

    /// A constant representing noon (12:00 PM) on the current day.
    static let noon: Date = Date.getThisTime(hour: 12, minute: 0)!

    // MARK: - Functions

    /// Adds a number of days to the current date and returns the resulting Date object.
    ///
    /// - Parameter days: The number of days to add.
    /// - Returns: A Date object representing the current date plus the specified number of days.
    @available(iOS 13.0, *)
    public func addDays(_ days: Double) -> Date {
        addHours(days * 24)
    }

    /// Adds a number of hours to the current date and returns the resulting Date object.
    ///
    /// - Parameter hours: The number of hours to add.
    /// - Returns: A Date object representing the current date plus the specified number of hours.
    @available(iOS 13.0, *)
    public func addHours(_ hours: Double) -> Date {
        advanced(by: hours * 60 * 60)
    }

    /// Adds a number of minutes to the current date and returns the resulting Date object.
    ///
    /// - Parameter minutes: The number of minutes to add.
    /// - Returns: A Date object representing the current date plus the specified number of minutes.
    @available(iOS 13.0, *)
    public func addMinutes(_ minutes: Double) -> Date {
        advanced(by: minutes * 60)
    }

    /// Returns the beginning of the day for a given date.
    ///
    /// - Parameter day: The date to get the beginning of the day for. Defaults to the current date.
    /// - Returns: The beginning of the day for the specified date.
    static public func beginningOfDay(_ day: Date = Date()) -> Date {
        Date.getThisTime(hour: 0, minute: 0, second: 1, from: day)!
    }

    /// Returns the end of the day for a given date.
    ///
    /// - Parameter day: The date to get the end of the day for. Defaults to the current date.
    /// - Returns: The end of the day for the specified date.
    static public func endOfDay(_ day: Date = Date()) -> Date {
        Date.getThisTime(hour: 23, minute: 59, second: 59, from: day)!
    }

    /// Converts a string representation of a date to a Date object using a specified format.
    ///
    /// - Parameters:
    /// - str: The string to convert to a Date object.
    /// - format: The format to use to interpret the string. Defaults to "MM/dd/yyyy".
    /// - Returns: A Date object representing the date represented by the input string.
    static public func getDateFromString(_ str: String, format: String = "MM/dd/yyyy") -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        return dateFormatterGet.date(from: str)
    }

    /// Calculates the number of weekend days and working days (i.e., non-weekend days) between two dates.
    ///
    /// - Parameters:
    /// - start: The start date.
    /// - end: The end date.
    /// - Returns: A tuple containing the number of weekend days and the number of working days.
    static public func dayTypes(from start: Date, to end: Date) -> (weekendDays: Int, workingDays: Int) {
        guard start < end else { return (0, 0) }
        var weekendDays = 0
        var workingDays = 0
        var date = start.noon
        repeat {
            if date.isDateInWeekend {
                weekendDays += 1
            } else {
                workingDays += 1
            }
            date = date.tomorrow
        } while date < end
        return (weekendDays, workingDays)
    }

    /// Returns a formatted date string based on the given format string.
    /// - Parameters:
    /// - format: A string representing the desired format for the date.
    /// - amPMCapitalized: A boolean value indicating whether the AM/PM symbol should be capitalized.
    /// - Returns: A string representation of the date formatted according to the given format string.

    public func getFormattedDate(format: String, amPMCapitalized: Bool = true) -> String {
        // Create a DateFormatter object to format the date.
        let dateformat = DateFormatter()

        // Set the date format based on the input parameter.
        dateformat.dateFormat = format

        // Set the AM/PM symbol based on the input parameter.
        dateformat.amSymbol = amPMCapitalized ? "AM" : "am"
        dateformat.pmSymbol = amPMCapitalized ? "PM" : "pm"

        // Use the date formatter to convert the date to a string using the specified format.
        return dateformat.string(from: self)
    }

    /// Returns a formatted string representation of the date using the specified format.
    ///
    /// - Parameters:
    /// - format: The format to use for the string representation of the date.
    /// - amPMCapitalized: A Boolean value indicating whether the "AM" and "PM" designations in the formatted string should be capitalized. Defaults to true.
    /// - Returns: A formatted string representation of the date using the specified format.
    public func getFormattedDate(format: DateFormats, amPMCapitalized: Bool = true) -> String {
        getFormattedDate(format: format.description, amPMCapitalized: amPMCapitalized)
    }

    /// Returns the day of the week, abbreviated to three letters, for a specified number of days before the current date.
    ///
    /// - Parameter daysBack: The number of days before the current date to get the day of the week for.
    /// - Returns: The day of the week, abbreviated to three letters (e.g. "Mon"), for the specified date.
    static public func getDayOfWeek(daysBack: Int) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let previousDay = calendar.date(byAdding: .day, value: -daysBack, to: currentDate)
        let dayOfWeek = calendar.component(.weekday, from: previousDay!)
        switch dayOfWeek {
            case 1:
                return "Sun"
            case 2:
                return "Mon"
            case 3:
                return "Tue"
            case 4:
                return "Wed"
            case 5:
                return "Thu"
            case 6:
                return "Fri"
            case 7:
                return "Sat"
            default:
                return "Invalid day"
        }
    }

    /// Format a given number of seconds into a string representation that includes hours, minutes, and/or seconds.
    /// - Parameters:
    /// - seconds: The number of seconds to format.
    /// - allowedUnits: An array of NSCalendar.Unit values indicating which units should be included in the formatted string (defaulting to .hour, .minute, and .second).
    /// - unitsStyle: A DateComponentsFormatter.UnitsStyle value indicating how the units should be abbreviated or spelled out (defaulting to .abbreviated).
    /// - Returns: A formatted string representing the number of hours, minutes, and/or seconds based on the specified units and style. If an error occurs during formatting, the method returns the string "SOMETHING WRONG".
    static public func secondsFormatted(_ seconds: Double, allowedUnits: NSCalendar.Unit = [.hour, .minute, .second], unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated) -> String {
        let interval = seconds
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = unitsStyle

        guard let formattedString = formatter.string(from: TimeInterval(interval)) else {
            return "SOMETHING WRONG"
        }
        return formattedString
    }

    /// Gets the date and time for a specified hour and minute on the current day.
    ///
    /// - Parameters:
    ///   - hour: The hour to set for the date and time.
    ///   - minute: The minute to set for the date and time.
    ///   - second: The second to set for the date and time. Defaults to 0.
    ///   - date: The date to set the hour and minute on. Defaults to the current date.
    /// - Returns: The date and time with the specified hour and minute.
    static public func getThisTime(hour: Int, minute: Int, second: Int = 0, from date: Date = .init()) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = Calendar.current.component(.year, from: date)
        dateComponents.month = Calendar.current.component(.month, from: date)
        dateComponents.day = Calendar.current.component(.day, from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create date from components
        return Calendar(identifier: .gregorian).date(from: dateComponents)
    }

    /// DateFormats is an enumeration representing various date and time formats as string values. It also conforms to CustomStringConvertible to provide a custom string representation for each date format.
    public enum DateFormats: String, CustomStringConvertible {
        /// A string representation of the format "h:mm a". Example: "12:00 AM".
        case minimalTime = "h:mm a"

        /// A string representation of the format "MMM d, yyyy". Example: "Jul 22, 2020".
        case abreviatedMonth = "MMM d, yyyy"

        /// A string representation of the format "MMM d". Example: "Jul 22".
        case monthDay = "MMM d"

        /// A string representation of the format "M/d/yyyy". Example: "07/22/2020".
        case slashDate = "M/d/yyyy"

        /// A string representation of the format "MM/d/yyyy". Example: "07/22/2020".
        case slashDateZeros = "MM/d/yyyy"

        /// A string representation of the format "MMM d, yyyy h:mm a". Example: "Jul 22, 2020 12:00 AM".
        case abreviatedMonthAndMinimalTime = "MMM d, yyyy h:mm a"

        /// A string representation of the format "MM/dd/yyyy HH:mm:ss". Example: "07/22/2020 00:00:00".
        case all = "MM/dd/yyyy HH:mm:ss"

        public var description: String { rawValue }
    }
}
