//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

extension Double {
    /// Provides a convenient method for rounding a Double value to a specified number of decimal places.
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: The rounded Double value.
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Returns a string representation of a rounded Double value, with options to remove trailing zeros and/or leading zeros before the decimal point.
    /// - Parameters:
    /// - places: The number of decimal places to round to. Defaults to 1.
    /// - removeFrontZero: A Boolean value indicating whether to remove leading zeros before the decimal point. Defaults to false.
    /// - Returns: A string representation of the rounded Double value, with optional formatting applied.
    func simpleStr(_ places: Int = 1, _ removeFrontZero: Bool = false) -> String {
        let rounded = roundTo(places: places)
        if rounded.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(rounded))
        } else {
            if removeFrontZero {
                let split = String(rounded).components(separatedBy: ".")
                if let back = split.safeGet(at: 1) {
                    return "." + back
                }
                return String(rounded)
            }

            return String(rounded)
        }
    }

    /// A utility function that formats a numeric value as a currency string with an optional inclusion of cents.
    ///
    /// - Parameter includeCents: A boolean value indicating whether or not to include cents in the formatted string. Default value is true.
    ///
    /// - Returns: A String representation of the numeric value formatted as currency.
    ///
    /// This function formats a numeric value as a currency string using the NumberFormatter class. The locale property of the formatter is set to the current locale, and the numberStyle property is set to .currency.

    /// If includeCents is true, the formatted string includes cents, and if it is false, the cents are removed from the formatted string.

    /// The formatted string is then cleaned up and returned by the cleanDollarAmount function, which removes any leading or trailing dollar signs and formats any .00 cents amounts as whole dollar amounts. The cleaned string is then returned as the result of this function.

    /// If the numeric value cannot be formatted using the NumberFormatter class, this function returns the original value as a string.
    func formattedForMoney(includeCents: Bool = true) -> String {
        func cleanDollarAmount(amount: String) -> String {
            let dollarAmount = amount.trimmingCharacters(in: ["$"])
            if dollarAmount.isEmpty {
                return "$0"
            } else if dollarAmount.hasSuffix(".00") {
                return "$" + dollarAmount.replacingOccurrences(of: ".00", with: "")
            } else {
                return "$" + dollarAmount
            }
        }

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency

        if let formattedValue = formatter.string(from: self as NSNumber) {
            let retVal = includeCents ? formattedValue : formattedValue.removeAllAfter(".")
            return cleanDollarAmount(amount: retVal)
        }

        return "\(self)"
    }

    /// A utility function that formats a numeric value as a currency string with an extended precision, up to 11 decimal places.
    ///
    /// - Parameter decimalPlaces: An optional integer value indicating the number of decimal places to include in the formatted string. The default value is 4.
    ///
    /// - Returns: A String representation of the numeric value formatted as currency with the specified number of decimal places.
    ///
    /// This function first extracts the currency symbol from the current locale and converts it to a Unicode.Scalar value. It then uses this value to create a String containing the currency symbol, followed by the original numeric value self.

    /// The function then calls the cleanDollarAmount function to format the currency value. This function takes a String parameter amount and an integer parameter decimals, and formats the currency value with the specified number of decimal places.

    /// If amount is empty, this function returns an empty string. Otherwise, it formats the value with up to 11 decimal places and rounds the value to the nearest cent. If the resulting value ends with ".00", this function removes the decimal point and trailing zeroes.

    /// The resulting string is then returned as the result of this function.
    func formattedForMoneyExtended(decimalPlaces: Int = 4) -> String {
        guard let currencySymbol = Locale.current.currencySymbol,
              let unicodeScalar = Unicode.Scalar(currencySymbol.unicodeScalars.first?.value ?? 36) else { return "" }
        func cleanDollarAmount(amount: String, decimals: Int) -> String {
            var decimalPlaces = decimals
            let dollarAmount = amount.trimmingCharacters(in: [unicodeScalar])
            if dollarAmount.isEmpty {
                return "$0"
            } else {
                var roundedAmount = String(format: "%.\(decimalPlaces)f", Double(dollarAmount) ?? 0.0)
                while roundedAmount.hasSuffix("0") && decimalPlaces < 11 {
                    decimalPlaces += 1
                    roundedAmount = String(format: "%.\(decimalPlaces)f", Double(dollarAmount) ?? 0.0)
                }
                func decimalSubstring(amount: String) -> String {
                    let parts = amount.split(separator: ".")
                    if parts.count == 2 {
                        return String(parts[1])
                    } else {
                        return ""
                    }
                }
                func integerSubstring(amount: String) -> String {
                    let parts = amount.split(separator: ".")
                    if parts.count >= 1 {
                        return String(parts[0])
                    } else {
                        return ""
                    }
                }

                var retVar: String

                if roundedAmount.hasSuffix(".00") {
                    retVar = "$" + roundedAmount.replacingOccurrences(of: ".00", with: "")
                } else {
                    retVar = "$" + roundedAmount
                }

                var strFollowingDecimal = decimalSubstring(amount: retVar)
                let strBeforeDecimal = integerSubstring(amount: retVar)

                while strFollowingDecimal.count > 2 && strFollowingDecimal.hasSuffix("0") {
                    _ = strFollowingDecimal.popLast()
                }

                return strBeforeDecimal + "." + strFollowingDecimal
            }
        }
        return cleanDollarAmount(amount: currencySymbol + "\(self)", decimals: decimalPlaces)
    }

    /// A utility function that formats a numeric value as a string representing a time interval in hours and minutes.
    ///
    /// - Parameter allowedUnits: An optional NSCalendar.Unit value specifying the units to use for formatting the time interval. The default value is [.hour, .minute].
    ///
    /// - Returns: A formatted string representation of the numeric value as a time interval.
    ///
    /// This function calls the secondsFormatted(_:allowedUnits:) class method of the Date class to format the numeric value as a string representing a time interval in hours and minutes. The allowedUnits parameter specifies the units to use for formatting the time interval. The default value is [.hour, .minute], which formats the time interval in hours and minutes only.

    /// The resulting string is then returned as the result of this function.
    func formatForTime(_ allowedUnits: NSCalendar.Unit = [.hour, .minute]) -> String {
        Date.secondsFormatted(self, allowedUnits: allowedUnits)
    }

    /// A utility function that formats a numeric value as a string representing a baseball statistic with three decimal places.
    ///
    /// - Returns: A formatted string representation of the numeric value as a baseball statistic.
    ///
    /// This function uses the roundTo(places:) method to round the numeric value to three decimal places, and then formats the rounded value as a string with three decimal places using the String(format:) initializer.

    /// If the formatted string starts with "0.", this function returns the string with the leading "0" removed. Otherwise, it returns the formatted string with three decimal places.

    /// The resulting string is then returned as the result of this function.
    func formatForBaseball() -> String {
        let formattedValue = String(format: "%.3f", roundTo(places: 3))
        if formattedValue.hasPrefix("0.") {
            return String(formattedValue.dropFirst(1))
        }
        return formattedValue
    }

    /// A computed property that returns a string representation of the numeric value, with a trailing zero if the value is rounded to the nearest tenth but not to the nearest hundredth.
    ///
    /// - Returns: A string representation of the numeric value, with a trailing zero if applicable.
    ///
    /// This property first rounds the numeric value to the nearest tenth and the nearest hundredth using the roundTo(places:) method. It then compares the rounded values to see if they are equal.

    /// If the rounded values are equal, this property returns the string representation of the original numeric value with a trailing zero added. Otherwise, it returns the string representation of the original numeric value without a trailing zero.

    /// The resulting string is then returned as the result of this property.
    var str: String {
        let roundTens = roundTo(places: 1)
        let roundHundreds = roundTo(places: 2)
        if roundTens == roundHundreds {
            return "\(self)0"
        }
        return "\(self)"
    }

    /// A utility function that returns a string representation of the numeric value, with an optional trailing zero.
    ///
    /// - Parameter includeSecondZero: A boolean value indicating whether or not to include a trailing zero when the value is rounded to the nearest tenth but not to the nearest hundredth. The default value is false.
    ///
    /// - Returns: A string representation of the numeric value, with an optional trailing zero.
    ///
    /// This function first rounds the numeric value to the nearest tenth and the nearest hundredth using the roundTo(places:) method. It then compares the rounded values to see if they are equal.

    /// If includeSecondZero is true and the rounded values are equal, this function returns the string representation of the original numeric value with a trailing zero added. Otherwise, it returns the string representation of the original numeric value without a trailing zero.

    /// The resulting string is then returned as the result of this function.
    func str(includeSecondZero: Bool = false) -> String {
        let roundTens = roundTo(places: 1)
        let roundHundreds = roundTo(places: 2)
        if roundTens == roundHundreds,
           includeSecondZero {
            return "\(self)0"
        }
        return "\(self)"
    }

    /// A computed property that returns the DateComponentsFormatter.UnitsStyle to use for formatting a time interval with this numeric value.
    ///
    /// - Returns: A DateComponentsFormatter.UnitsStyle value indicating the units style to use for formatting the time interval.
    ///
    /// This property first checks if the numeric value is less than 60, in which case it returns .abbreviated.

    /// If the numeric value is greater than or equal to 60 but less than 3600 (1 hour), and the number of minutes is a whole number (no remainder when dividing by 60), this property returns .abbreviated.

    /// Otherwise, this property returns .positional.

    /// The resulting DateComponentsFormatter.UnitsStyle value is then returned as the result of this property.
    var unitsStyle: DateComponentsFormatter.UnitsStyle {
        if self < 60 {
            return .abbreviated
        }
        if self < 60 * 60 && truncatingRemainder(dividingBy: 60) == 0 {
            return .abbreviated
        }
        return .positional
    }
}
