//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 4/29/23.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
    /// An extension to the Sequence type that provides a method for checking if the sequence intersects with another sequence.
    ///
    /// - Parameters:
    /// - sequence: Another sequence to check for intersection.
    ///
    /// - Returns: A Bool indicating whether the sequence intersects with the other sequence.
    ///
    /// This extension adds a method to the Sequence type that checks if the sequence intersects with another sequence. The method takes another sequence as an argument and checks if any of the elements in the sequence are also in the other sequence.

    /// First, the method creates a Set from the other sequence to allow for fast lookups. Then, it uses the contains(where:) method to check if any of the elements in the sequence are also in the other sequence.

    /// The resulting Bool value indicates whether the sequence intersects with the other sequence.
    func intersects<S: Sequence>(with sequence: S) -> Bool
        where S.Iterator.Element == Iterator.Element {
        let sequenceSet = Set(sequence)
        return contains(where: sequenceSet.contains)
    }
}
