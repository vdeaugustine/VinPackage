//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation

// MARK: - Element is a Double

public extension Array where Element == Double {
    /// An extension to the Array type that provides a method for calculating the standard deviation of an array of Double values.
    ///
    /// - Returns: A Double representing the standard deviation of the array.
    ///
    /// This extension adds a method to the Array type that calculates the standard deviation of an array of Double values. The method first calculates the average of the values in the array by dividing the sum of the values by the number of values.

    /// Then, it calculates the variance of the values in the array by subtracting the average from each value, squaring the result, and taking the sum of the squared values, divided by the number of values.

    /// Finally, it calculates the standard deviation by taking the square root of the variance.

    /// The resulting Double value represents the standard deviation of the array.
    func standardDeviation() -> Double {
        let count = Double(self.count)
        let average = reduce(0, +) / count
        let variance = map { pow($0 - average, 2) }.reduce(0, +) / count
        let standardDeviation = sqrt(variance)
        return standardDeviation
    }
}

// MARK: - All Array

public extension Array {
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

    /// An extension to the Array type that provides a method for returning a prefix subarray of a given length.
    ///
    /// - Parameter num: The number of elements to include in the subarray.
    ///
    /// - Returns: An array containing the first num elements of the original array.
    ///
    /// This extension adds a method to the Array type that returns a subarray containing the first num elements of the original array. The method first uses the prefix(_:) method to create a subsequence of the first num elements, and then converts the subsequence to an array using the Array(_:) initializer.

    /// The resulting array contains the first num elements of the original array. If the original array has fewer than num elements, the resulting array will have fewer elements than num.
    func prefixArray(_ num: Int) -> [Element] {
        Array(prefix(num))
    }

    /// An extension to the Array type that provides a method for returning a suffix subarray of a given length.
    ///
    /// - Parameter num: The number of elements to include in the subarray.
    ///
    /// - Returns: An array containing the last num elements of the original array.
    ///
    /// This extension adds a method to the Array type that returns a subarray containing the last num elements of the original array. The method first uses the suffix(_:) method to create a subsequence of the last num elements, and then converts the subsequence to an array using the Array(_:) initializer.

    /// The resulting array contains the last num elements of the original array. If the original array has fewer than num elements, the resulting array will have fewer elements than num.
    func suffixArray(_ num: Int) -> [Element] {
        Array(suffix(num))
    }

    /// An extension to the Array type that provides a method for joining the elements of an array into a single string.
    ///
    /// - Parameter separator: A String used to separate the elements of the array in the resulting string.
    ///
    /// - Returns: A String containing the elements of the array joined together with the specified separator.
    ///
    /// This extension adds a method to the Array type that combines the elements of the array into a single String with the specified separator. The method loops through each element in the array and appends it to a new array of String values.

    /// If an element in the array is a Double or Int, it is first converted to a String using the str or str() computed property, respectively. Otherwise, the element is converted to a String using the default String initializer.

    /// The resulting String is then returned, with each element separated by the specified separator.
    func joinString(_ separator: String) -> String {
        var arr: [String] = []
        for item in self {
            if let dub = item as? Double {
                arr.append(dub.simpleStr())
            } else if let int = item as? Int {
                arr.append(int.str)
            } else {
                arr.append("\(item)")
            }
        }
        return arr.joined(separator: separator)
    }

    /// Accesses the element at the specified position in a safe way, returning `nil` if the index is out of bounds.
    ///
    /// This subscript allows you to access elements with negative indices, where the index `-n` corresponds to the nth element from the end of the array.
    ///
    /// - Parameter index: The position of the element to access. `index` can be negative.
    /// - Returns: The element at the specified position, if the index is within the bounds of the array; otherwise, `nil`.
    ///
    /// # Examples
    ///
    ///     let array = [1, 2, 3, 4, 5]
    ///
    ///     print(array[safe: 1])  // Optional(2)
    ///     print(array[safe: -2]) // Optional(4)
    ///     print(array[safe: 7])  // nil
    ///     print(array[safe: -6]) // nil
    ///
    subscript(safe index: Int) -> Element? {
        if index >= 0 {
            return indices.contains(index) ? self[index] : nil
        } else {
            let positiveIndex = count + index
            return indices.contains(positiveIndex) ? self[positiveIndex] : nil
        }
    }
}

// MARK: - Element is Equatable

public extension Array where Element: Equatable {
    /// An extension to the Array type that provides a method for finding the intersection of two arrays.
    ///
    /// - Parameter other: Another array to check for intersection.
    ///
    /// - Returns: An array containing the intersection of the two arrays.
    ///
    /// This extension adds a method to the Array type that finds the intersection of two arrays. The method takes another array as an argument and returns a new array containing the elements that are common to both arrays.

    /// The method loops through each element in the first array and checks if it is also in the other array using the contains method. If an element is found in both arrays and is not already in the result array, it is appended to the result array.

    /// The resulting array contains the intersection of the two arrays, with each element appearing only once.
    func intersection(_ other: [Element]) -> [Element] {
        var result = [Element]()
        for item in self {
            if other.contains(item) && !result.contains(item) {
                result.append(item)
            }
        }
        return result
    }

    /// Returns an array of indices for all occurrences of the specified element.
    ///
    /// - Parameter element: The element to find in the array.
    /// - Returns: An array of indices for all occurrences of the specified element. If the element is not found, an empty array is returned.
    func allIndices(of element: Element) -> [Int] {
        var indices: [Int] = []
        for (index, value) in enumerated() {
            if value == element {
                indices.append(index)
            }
        }
        return indices
    }

    /**
        Removes all occurrences of the specified element from the collection.

        This function iterates through the collection and removes all instances of the specified element. After the function call, the collection will not contain any instances of the given element.

        - Parameter element: The element to be removed from the collection.

        - Complexity: O(n), where n is the length of the collection.
     */
    mutating func removeAll(of element: Element) {
        removeAll { $0 == element }
    }

    /**
       Mutates the collection by either inserting a new element or removing an existing one.

       This function first checks if the element already exists in the collection. If it does, the function removes that element. If the element does not exist, it will try to insert it at the specified index, if provided.

       If the specified index is not within the bounds of the collection or if no index is provided, the function appends the element to the end of the collection.

       - Parameters:
          - element: The element to be inserted or removed from the collection.
          - index: The index at which the new element should be inserted, if it is not already present in the collection. Defaults to `nil`, in which case the element is appended to the end of the collection if it doesn't already exist.

       - Complexity: O(n), where n is the length of the collection.
     */
    mutating func insertOrRemove(element: Element, atIndex index: Int? = nil) {
        if let existingIndex = firstIndex(of: element) {
            remove(at: existingIndex)
        } else {
            if let index = index,
               index >= 0,
               index < count {
                insert(element, at: index)
            } else {
                append(element)
            }
        }
    }
}
