//
//  ExtStr.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

public extension String {
    /// A utility function that removes all characters after the specified character in a string.
    ///
    /// - Parameter character: The character after which all characters should be removed.
    ///
    /// - Returns: A String with all characters after the specified character removed.
    ///
    /// This function takes a String parameter character and removes all characters in the original string self that appear after the specified character. If the specified character does not appear in the string, the original string is returned unchanged.

    /// The function first creates a copy of the original string self to avoid mutating the original. It then uses the range(of:) method of the string to find the range of the specified character. If the specified character is found, it removes all characters from that range to the end of the string using the removeSubrange(_:) method. The modified string is then returned as the result of this function.
    func removeAllAfter(_ character: String) -> String {
        var str = self
        if let charRange = str.range(of: character) {
            str.removeSubrange(charRange.lowerBound ..< str.endIndex)
        }
        return str
    }

    /// An extension to the String type that provides a method for extracting a Double value from a string containing a dollar amount.
    ///
    /// - Returns: An optional Double representing the dollar amount extracted from the string.
    ///
    /// This extension adds a method to the String type that extracts a Double value from a string that contains a dollar amount. The method first removes the dollar sign ($) from the string using the replacingOccurrences(of:with:) method.

    /// Then, it attempts to convert the resulting string to a Double value using the Double(_:) initializer.

    /// If the string can be converted to a Double value, the resulting Double value is returned as an optional. If the string cannot be converted to a Double value, the method returns nil.
    func getDoubleFromMoney() -> Double? {
        let editedStr = replacingOccurrences(of: "$", with: "")
        return Double(editedStr)
    }

    /// An extension to the String type that provides a method for formatting a string as a dollar amount.
    ///
    /// - Parameter makeCents: A Boolean value indicating whether to include cents in the formatted string.
    ///
    /// - Returns: A string formatted as a dollar amount, with or without cents depending on the value of makeCents.
    ///
    /// This extension adds a method to the String type that formats a string as a dollar amount. The method first attempts to convert the string to a Double value using the Double(_:) initializer.

    /// If the conversion is successful, the resulting Double value is divided by 100 if makeCents is true, and then passed to the formattedForMoney(includeCents:) method to create a formatted string.

    /// If the conversion is unsuccessful, the method returns an empty string.
    func makeMoney(makeCents: Bool) -> String {
        var amount: Double = 0
        if let dub = Double(self) {
            amount = makeCents ? (dub / 100) : dub
        }
        return amount.formattedForMoney(includeCents: makeCents)
    }

    /// An extension to the String type that provides a method for removing all characters in the string after and including a specified character.
    ///
    /// - Parameter character: The character after which to remove all characters in the string.
    ///
    /// - Returns: A new string with all characters after and including the specified character removed.
    ///
    /// This extension adds a method to the String type that removes all characters in the string after and including a specified character. The method first finds the range of the specified character using the range(of:) method.

    /// If the character is found in the string, the method removes all characters in the string after and including the specified character using the removeSubrange(_:) method, and returns the modified string.

    /// If the character is not found in the string, the method returns the original string.
    func removeAllAfterAndIncluding(_ character: String) -> String {
        var str = self
        if let charRange = str.range(of: character) {
            str.removeSubrange(charRange.lowerBound ... str.endIndex)
        }
        return str
    }

    /// An extension to the String type that provides a method for removing all white spaces from the string.
    ///
    /// - Returns: A new string with all white spaces removed.
    ///
    /// This extension adds a method to the String type that removes all white spaces from the string using the components(separatedBy:) method to split the string into an array of substrings separated by whitespace characters, and then joining the substrings back together using the joined() method. The resulting string has all white spaces removed.
    func removingWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    /// An extension to the String type that provides a method for joining the string with other strings using a separator.
    ///
    /// - Parameters:
    /// - otherStrings: An array of strings to join with the original string.
    /// - separator: The separator to use when joining the strings. Default is a single space character.
    /// - Returns: A new string that is the result of joining the original string with the other strings using the specified separator.
    ///
    /// This extension adds a method to the String type that joins the original string with other strings using a separator. The method accepts an array of strings to join with the original string, and a separator string that defaults to a single space character. The method creates a new array containing the original string and the other strings, and then uses the joined(separator:) method to join the elements of the array into a new string using the specified separator. The resulting string is then returned.
    func join(with otherStrings: [String], _ separator: String = " ") -> String {
        var arr = otherStrings
        arr.insert(self, at: 0)
        return arr.joined(separator: separator)
    }

    /// Appends a string to a string only if it does not already contain it.
    ///
    /// - Parameters:
    /// - string: The string to be appended, if not already contained.
    /// - separator: The separator to be used between existing string and the appended string. Defaults to ",".
    ///
    /// Modifies the string instance that this function is called on. If the provided string is nil or the receiver already contains the provided string, no changes will be made. If the receiver is empty, the provided string will be appended without the separator. Otherwise, the provided separator will be used to join the current value and the new string.
    mutating func appendIfNotContains(_ string: String?, separator: String = ",") {
        guard let string = string else { return }
        if !contains(string) {
            if isEmpty {
                self = string
            } else {
                self += "\(separator)\(string)"
            }
        }
    }

    /**
     This function removes all accents (diacritical marks) from a given string.

     Example usage:

         let accentedString = "Café"
         let unaccentedString = removeAccents(from: accentedString)
         print(unaccentedString) // "Cafe"

     - Returns: A new string with all accents removed.
     */
    func removeAccents() -> String {
        // Decompose the string with canonical mapping to separate the base character and its accent.
        let decomposedString = decomposedStringWithCanonicalMapping

        // Filter out all non-spacing and spacing marks, which include accents.
        let filteredScalars = decomposedString.unicodeScalars.filter { scalar in
            let generalCategory = scalar.properties.generalCategory
            return generalCategory != .nonspacingMark && generalCategory != .spacingMark
        }

        // Recompose the remaining scalars into a new string without accents.
        let resultString = String(filteredScalars)

        // Return the new string without accents.
        return resultString
    }

    /**
     This function removes all non-alphanumeric characters from a given string, except for the period (.) and hyphen (-) characters.

      Example usage:

          let unfilteredString = "This is a string with non-alphanumeric characters: $10, !@#$%^&*()-+={}[]|\:;'<>,.?/~`"
          let filteredString = removingNonAlphanumericCharacters(from: unfilteredString)
          print(filteredString) // "This is a string with non-alphanumeric characters 10-"

      - Returns: A new string with all non-alphanumeric characters removed, except for the period (.) and hyphen (-) characters.
      */
    func removingNonAlphanumericCharacters() -> String {
        // Define the set of allowed characters, which includes all alphanumeric characters, as well as the period (.) and hyphen (-) characters.
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: ".-"))
        // Filter out all non-allowed characters from the input string and join the remaining components into a new string.
        let filteredString = components(separatedBy: allowedCharacters.inverted).joined()

        // Return the new string without non-alphanumeric characters, except for the period (.) and hyphen (-) characters.
        return filteredString
    }

    /// Returns a new string containing the first `n` characters of the original string.
    ///
    /// - Parameter n: The number of characters to take from the beginning of the string.
    ///                If `n` is less than or equal to 0, an empty string will be returned.
    ///                If `n` is greater than the string's length, the whole string will be returned.
    /// - Returns: A string containing the first `n` characters of the original string.
    func prefixStr(_ n: Int) -> String {
        guard n > 0 else {
            return ""
        }

        let endIndex = index(startIndex, offsetBy: min(n, count))
        return String(self[startIndex ..< endIndex])
    }

    /// Returns a new string containing the last `n` characters of the original string.
    ///
    /// - Parameter n: The number of characters to take from the end of the string.
    ///                If `n` is less than or equal to 0, an empty string will be returned.
    ///                If `n` is greater than the string's length, the whole string will be returned.
    /// - Returns: A string containing the last `n` characters of the original string.
    func suffixStr(_ n: Int) -> String {
        guard n > 0 else {
            return ""
        }

        let startIndex = index(endIndex, offsetBy: -min(n, count))
        return String(self[startIndex ..< endIndex])
    }
}
