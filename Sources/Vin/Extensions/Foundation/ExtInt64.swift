//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 3/23/23.
//

import Foundation

extension Int64 {
    
    /// Creates a new `Int64` instance from an optional `String`.
    ///
    /// If the string can be parsed as an integer, the initializer returns a new `Int64` instance
    /// containing the parsed value. If the string is `nil`, the initializer returns `nil`.
    ///
    /// - Parameter string: The string to parse as an integer.
    ///
    /// - Returns: A new `Int64` instance containing the parsed value of `string`, or `nil` if
    ///   `string` could not be parsed as an integer.
    ///
    /// - Note: This initializer uses the `init?(_ text: String, radix: Int = default)` initializer
    ///   provided by `Int64` to parse the string as an integer. If the string cannot be parsed as an
    ///   integer, the initializer returns `nil`.
    public init?(string: String?) {
        guard let string = string else { return nil }
        self.init(string, radix: 10)
    }
}
