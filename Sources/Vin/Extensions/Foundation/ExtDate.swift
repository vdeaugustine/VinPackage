//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

public extension Date {
    /// A Boolean value indicating whether the date is on a weekend day (Saturday or Sunday) using the ISO 8601 calendar.
    var isDateInWeekend: Bool {
        return Calendar.iso8601.isDateInWeekend(self)
    }

    /// Returns the date that represents tomorrow at noon (12:00 PM).
    var tomorrow: Date {
        return Calendar.iso8601.date(byAdding: .day,
                                     value: 1,
                                     to: noon)!
    }

    /// Returns the date at noon (12:00 PM) for the current date.
    var noon: Date {
        return Calendar.iso8601.date(bySettingHour: 12,
                                     minute: 0,
                                     second: 0,
                                     of: self)!
    }

    /// Returns the time interval between two dates by subtracting the time interval of one date from another.
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
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
    func addDays(_ days: Double) -> Date {
        addHours(days * 24)
    }

    /// Adds a number of hours to the current date and returns the resulting Date object.
    ///
    /// - Parameter hours: The number of hours to add.
    /// - Returns: A Date object representing the current date plus the specified number of hours.
    @available(iOS 13.0, *)
    func addHours(_ hours: Double) -> Date {
        advanced(by: hours * 60 * 60)
    }

    /// Adds a number of minutes to the current date and returns the resulting Date object.
    ///
    /// - Parameter minutes: The number of minutes to add.
    /// - Returns: A Date object representing the current date plus the specified number of minutes.
    @available(iOS 13.0, *)
    func addMinutes(_ minutes: Double) -> Date {
        advanced(by: minutes * 60)
    }

    /// Returns the beginning of the day for a given date.
    ///
    /// - Parameter day: The date to get the beginning of the day for. Defaults to the current date.
    /// - Returns: The beginning of the day for the specified date.
    static func beginningOfDay(_ day: Date = Date()) -> Date {
        Date.getThisTime(hour: 0, minute: 0, second: 1, from: day)!
    }

    /// Returns the end of the day for a given date.
    ///
    /// - Parameter day: The date to get the end of the day for. Defaults to the current date.
    /// - Returns: The end of the day for the specified date.
    static func endOfDay(_ day: Date = Date()) -> Date {
        Date.getThisTime(hour: 23, minute: 59, second: 59, from: day)!
    }

    /// Converts a string representation of a date to a Date object using a specified format.
    ///
    /// - Parameters:
    /// - str: The string to convert to a Date object.
    /// - format: The format to use to interpret the string. Defaults to "MM/dd/yyyy".
    /// - Returns: A Date object representing the date represented by the input string.
    static func getDateFromString(_ str: String, format: String = "MM/dd/yyyy") -> Date? {
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
    static func dayTypes(from start: Date, to end: Date) -> (weekendDays: Int, workingDays: Int) {
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

    func getFormattedDate(format: String, amPMCapitalized: Bool = true) -> String {
        // Create a DateFormatter object to format the date.
        let dateFormat = DateFormatter()

        // Set the date format based on the input parameter.
        dateFormat.dateFormat = format

        // Set the AM/PM symbol based on the input parameter.
        dateFormat.amSymbol = amPMCapitalized ? "AM" : "am"
        dateFormat.pmSymbol = amPMCapitalized ? "PM" : "pm"

        // Use the date formatter to convert the date to a string using the specified format.
        return dateFormat.string(from: self)
    }

    /// Returns a formatted string representation of the date using the specified format.
    ///
    /// - Parameters:
    /// - format: The format to use for the string representation of the date.
    /// - amPMCapitalized: A Boolean value indicating whether the "AM" and "PM" designations in the formatted string should be capitalized. Defaults to true.
    /// - Returns: A formatted string representation of the date using the specified format.
    func getFormattedDate(format: DateFormats, amPMCapitalized: Bool = true) -> String {
        getFormattedDate(format: format.description, amPMCapitalized: amPMCapitalized)
    }

    /**
      Converts a string in ISO 8601 format to a Date object.

      ISO 8601 is an international standard for representing dates and times as strings, which includes UTC format.

      - Parameter dateString: The string representation of the date in ISO 8601 format.

      - Returns: A Date object if the string could be successfully parsed, or `nil` if the string was in an incorrect format.

      Example Usage:

      ```swift
      let dateString = "2023-06-14T12:34:56Z"
      guard let date = convertToDate(dateString: dateString) else {
          print("Invalid date string")
          return
      }
      print("The date is \(date)")
     */
    static func UTCToDate(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return dateFormatter.date(from: dateString)
    }

    /// Converts the `Date` instance to a string representation in Coordinated Universal Time (UTC).
    ///
    /// The returned string is in ISO 8601 format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'".
    /// 'T' is the time delimiter, 'Z' denotes Zulu Time which is equivalent to UTC, and fractional seconds are represented with '.SSS'.
    /// This format is suitable for representing dates and times in a machine-readable format on an international basis.
    ///
    /// - Returns: A string representation of the `Date` in UTC.
    ///
    /// Example Usage:
    ///
    /// ```swift
    /// let now = Date()
    /// print(now.toUTC()) // Prints the current date and time in UTC.
    /// ```
    func toUTC() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = DateFormats.utc.description

        // Set time zone to UTC
        dateFormat.timeZone = TimeZone(secondsFromGMT: 0)

        return dateFormat.string(from: self)
    }

    /// Returns the day of the week, abbreviated to three letters, for a specified number of days before the current date.
    ///
    /// - Parameter daysBack: The number of days before the current date to get the day of the week for.
    /// - Returns: The day of the week, abbreviated to three letters (e.g. "Mon"), for the specified date.
    static func getDayOfWeek(daysBack: Int) -> String {
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
    static func secondsFormatted(_ seconds: Double, allowedUnits: NSCalendar.Unit = [.hour, .minute, .second], unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated) -> String {
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
    static func getThisTime(hour: Int, minute: Int, second: Int = 0, from date: Date = .init()) -> Date? {
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
    enum DateFormats: String, CustomStringConvertible {
        /// A string representation of the format "H:mm". Example: 5:00 PM would be "17:00"
        case militaryTime = "H:mm"

        /// A string representation of the format "h:mm a". Example: "12:00 AM".
        case minimalTime = "h:mm a"

        /// A string representation of the format "MMM d, yyyy". Example: "Jul 22, 2020".
        case abbreviatedMonth = "MMM d, yyyy"

        /// A string representation of the format "MMM d". Example: "Jul 22".
        case monthDay = "MMM d"

        /// A string representation of the format "M/d/yyyy". Example: "07/22/2020".
        case slashDate = "M/d/yyyy"

        /// A string representation of the format "MM/d/yyyy". Example: "07/22/2020".
        case slashDateZeros = "MM/d/yyyy"

        /// A string representation of the format "MMM d, yyyy h:mm a". Example: "Jul 22, 2020 12:00 AM".
        case abbreviatedMonthAndMinimalTime = "MMM d, yyyy h:mm a"

        /// A string representation of the format "MM/dd/yyyy HH:mm:ss". Example: "07/22/2020 00:00:00".
        case all = "MM/dd/yyyy HH:mm:ss"

        /// A string representation of the format "EEE. MMMM dd, yyyy". Example: "Wed. April 27, 2023".
        case shortWeekdayFullDayMonthYear = "EEE. MMMM dd, yyyy"

        /// yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ is an ISO 8601 format string
        /// with milliseconds (SSS) and timezone (ZZZZZ) included for maximum
        ///
        ///     // Example usage:
        ///     let dateString = "2023-04-29T16:15:30.123-07:00"
        case precise = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

        /// A string representation of the UTC (Coordinated Universal Time) format in ISO 8601: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'".
        /// 'T' is the time delimiter, 'Z' denotes Zulu Time which is equivalent to UTC, and fractional seconds are represented with '.SSS'.
        /// This format is suitable for representing dates and times in a machine-readable format on an international basis.
        ///
        /// Example: "2023-06-13T00:07:02.054Z" represents June 13, 2023, just past midnight (00:07 and 2.054 seconds) in Coordinated Universal Time.
        case utc = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        public var description: String { rawValue }
    }

    /// Returns an array of the previous `count` weekday dates, excluding weekends.
    ///
    /// This function iterates through past dates and appends them to an array if they are weekdays
    /// (i.e., Monday to Friday). It continues this process until the required number of weekdays
    /// is collected, as specified by the `count` parameter.
    ///
    /// - Parameter count: The number of weekdays to include in the returned array.
    ///
    /// - Returns: An array of `Date` objects representing the previous `count` weekdays.
    static func getPreviousWeekdays(count: Int) -> [Date] {
        var weekdays: [Date] = []
        var dayCount = 0
        var date = Date()

        while weekdays.count < count {
            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            let components = Calendar.current.dateComponents([.weekday], from: date)

            if let weekday = components.weekday, weekday >= 2 && weekday <= 6 {
                weekdays.append(date)
            }

            dayCount += 1
            if dayCount > 365 {
                break // exit loop if we've gone back a year and haven't found enough weekdays
            }
        }

        return weekdays
    }

    /// Returns an array of the next `count` weekday dates, excluding weekends.
    ///
    /// This function iterates through future dates and appends them to an array if they are weekdays
    /// (i.e., Monday to Friday). It continues this process until the required number of weekdays
    /// is collected, as specified by the `count` parameter.
    ///
    /// - Parameter count: The number of weekdays to include in the returned array.
    ///
    /// - Returns: An array of `Date` objects representing the next `count` weekdays.
    static func getNextWeekdays(count: Int) -> [Date] {
        var weekdays = [Date]()
        var date = Date()

        while weekdays.count < count {
            date = date.addingTimeInterval(24 * 60 * 60)
            let weekday = Calendar.current.component(.weekday, from: date)
            if weekday >= 2 && weekday <= 6 {
                weekdays.append(date)
            }
        }

        return weekdays
    }

    /// Determines whether the given date is a normal weekday (AKA business day)
    /// - Parameter date: The date in consideration
    /// - Returns: A `Bool` that is `true` if the day is a weekday and `false` otherwise
    static func isWeekday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday >= 2 && weekday <= 6
    }

    /// Initializes a new `Date` instance from a provided string with the specified format.
    ///
    /// Example usage:
    ///
    /// ```swift
    /// Date(fromString: "02/04/1996")
    /// // Returns date representing February 4, 1996
    /// ```
    /// - Parameters:
    ///   - dateString: The string representation of the date, using the format specified by the `format` parameter.
    ///   - format: The format of the date string. Defaults to "MM/dd/yyyy".
    /// - Returns: A new `Date` instance if the string is valid and matches the format, otherwise `nil`.
    init?(fromString dateString: String, format: String = "MM/dd/yyyy") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        self = date
    }

    /**
       Checks if two given dates are both within either the AM or PM period of the same day.

       This function checks if two `Date` objects fall within the same AM or PM period of the same calendar day. The function first checks if the dates belong to the same day. If they do, it then verifies if both dates fall within the same period (AM or PM). Hours from 0 to 11 are considered AM, and hours from 12 to 23 are considered PM.

       - Parameters:
          - date1: The first `Date` to check.
          - date2: The second `Date` to check.

       - Returns: Returns `true` if both dates fall within the same AM or PM period of the same day. Returns `false` otherwise.

       # Example
       ```swift
       let date1 = Date()
       let date2 = Calendar.current.date(byAdding: .hour, value: 3, to: date1)!
       let isSamePeriod = isSameDayAndPeriod(date1: date1, date2: date2)
       ```

       - Author: Your Name
       - Version: 1.0
     */
    static func isSameDayAndPeriod(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let hour1 = calendar.component(.hour, from: date1)
        let hour2 = calendar.component(.hour, from: date2)

        let day1 = calendar.component(.day, from: date1)
        let day2 = calendar.component(.day, from: date2)

        // Check if they are the same day
        guard day1 == day2 else {
            return false
        }

        // Hours from 0 to 11 are AM, and from 12 to 23 are PM.
        let isAM1 = hour1 < 12
        let isAM2 = hour2 < 12

        return isAM1 == isAM2
    }

    /**
     Generates a formatted string that represents a range between two `Date` objects.

     The resulting string uses the 12-hour clock time format including the period (AM/PM) when the start and end dates fall on different days or different periods of the same day (AM/PM). If the start and end dates are within the same day and period, the resulting string will use a 24-hour clock time format without including the period (AM/PM).

     This function depends on the `isSameDayAndPeriod(date1:date2:)` method to determine if the two dates are within the same day and period and the `getFormattedDate(format:)` method to format each date into a string.

     - Parameter start: The start `Date` of the range.
     - Parameter end: The end `Date` of the range.

     - Returns: A formatted string that represents the time range, in the format of "hh:mm - hh:mm" or "hh:mm a - hh:mm a", depending on whether the start and end dates fall within the same day and period.

     ## Example
     ```swift
     let startTime = Date(timeIntervalSince1970: 1627200000) // July 25, 2023, at 4:00 AM
     let endTime = Date(timeIntervalSince1970: 1627243200) // July 25, 2023, at 4:00 PM
     let rangeString = timeRangeString(start: startTime, end: endTime)
     // Prints "4:00 AM - 4:00 PM"
     */
    static func timeRangeString(start: Date, end: Date) -> String {
        let firstStringFormat = isSameDayAndPeriod(date1: start, date2: end) ? "h:mm" : "h:mm a"

        let firstString = start.getFormattedDate(format: firstStringFormat)
        let secondString = end.getFormattedDate(format: .minimalTime)

        return "\(firstString) - \(secondString)"
    }

    /**
     An extension on `Date` that provides a method to apply the time components from another date object, with a specified granularity.

     ## Overview

     This extension adds a method to the `Date` type, allowing developers to create a new `Date` instance by combining the date components of the receiver with the time components from another `Date` object. You can specify the granularity of the time components to be applied.

     - Parameters:
       - otherDate: The `Date` object from which to extract the time components.
       - granularity: An array of `Calendar.Component` that specifies the granularity of the time components to be applied from `otherDate`. The default value is `[.hour, .minute]`.

     - Returns: A new `Date` object with the date components of the receiver and the time components from `otherDate`, according to the specified granularity. If the merging of components fails, it returns `nil`.

     ## Example

     ```swift
     let date1 = Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 26))!
     let date2 = Calendar.current.date(from: DateComponents(hour: 14, minute: 30))!

     if let mergedDate = date1.applyingTime(from: date2) {
         print(mergedDate) // prints "2023-09-26 14:30:00 +0000"
     }
     ```
     Discussion
     This method uses the current calendar to extract date and time components. The date components are extracted from the receiver, and the time components are extracted from otherDate with the specified granularity. These components are then merged to create a new Date object.

     The granularity parameter allows you to specify which time components you want to apply from otherDate. For example, if you pass [.hour, .minute, .second] for granularity, the resulting date will have the hour, minute, and second from otherDate, and the year, month, and day from the receiver.

     When using this method, consider the possible outcomes if the creation of the new Date instance fails due to the inability to merge components and handle them appropriately in your code.

     Note: The applyingTime(from:withGranularity:) method does not account for daylight saving time adjustments and may result in unexpected behaviors around the transitions.

     Warning: Ensure that the otherDate parameter is a valid date object with the required time components specified in the granularity, as the method does not validate the existence of the components in otherDate.

     */

    func applyingTime(from otherDate: Date, withGranularity granularity: [Calendar.Component] = [.hour, .minute]) -> Date? {
        let calendar = Calendar.current

        // Extract the time components from the other date
        let timeComponents = calendar.dateComponents(Set(granularity), from: otherDate)

        // Extract the date components from the current date
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)

        // Merge the two sets of components
        var mergedComponents = DateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day

        for component in granularity {
            switch component {
                case .hour:
                    mergedComponents.hour = timeComponents.hour
                case .minute:
                    mergedComponents.minute = timeComponents.minute
                case .second:
                    mergedComponents.second = timeComponents.second
                case .nanosecond:
                    mergedComponents.nanosecond = timeComponents.nanosecond
                default:
                    continue
            }
        }

        // Create a new date from the merged components
        return calendar.date(from: mergedComponents)
    }
}
