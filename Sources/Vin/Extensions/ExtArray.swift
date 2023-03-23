//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

extension Array {
    /// Returns a Boolean value indicating whether the provided index is within the bounds of the Array.
    /// - Parameter num: The index to check.
    /// - Returns: true if the index is within the bounds of the Array, otherwise false.
    func safeCheck(_ num: Int) -> Bool {
        return num >= 0 && num < count
    }

    /// Returns the element at a specified index within the Array, or nil if the index is out of bounds.
    /// - Parameter num: The index of the element to retrieve.
    /// - Returns: The element at the specified index, if it exists within the Array, otherwise nil.
    func safeGet(at num: Int) -> Element? {
        guard safeCheck(num) else { return nil }
        return self[num]
    }
}
