//
//  ArrayTests.swift
//
//
//  Created by Vincent DeAugustine on 4/29/23.
//

import XCTest

class ArrayExtensionTests: XCTestCase {
    func testPositiveIndex() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array[safe: 1], 2)
    }

    func testNegativeIndex() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array[safe: -2], 4)
    }

    func testOutOfBoundsPositiveIndex() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertNil(array[safe: 7])
    }

    func testOutOfBoundsNegativeIndex() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertNil(array[safe: -6])
    }

    func testEmptyArray() {
        let emptyArray: [Int] = []
        XCTAssertNil(emptyArray[safe: 0])
        XCTAssertNil(emptyArray[safe: -1])
    }

    func testJoinString() {
        // Test joining an array of strings
        let strings = ["apple", "banana", "cherry"]
        let expectedString = "apple, banana, cherry"
        XCTAssertEqual(strings.joinString(", "), expectedString)

        // Test joining an array of ints and doubles
        let numbers = [1, 2, 3, 4, 5.5, 6.6, 7]
        let expectedNumbersString = "1, 2, 3, 4, 5.5, 6.6, 7"
        XCTAssertEqual(numbers.joinString(", "), expectedNumbersString)

        // Test joining an empty array
        let emptyArray: [Any] = []
        let expectedEmptyString = ""
        XCTAssertEqual(emptyArray.joinString(", "), expectedEmptyString)

        // Test joining an array with only one element
        let singleElementArray = [5]
        let expectedSingleElementString = "5"
        XCTAssertEqual(singleElementArray.joinString(", "), expectedSingleElementString)
    }

    func testSuffixArrayWithPositiveNumber() {
        let array = [1, 2, 3, 4, 5]
        let expectedSuffix = [3, 4, 5]
        let suffix = array.suffixArray(3)

        XCTAssertEqual(suffix, expectedSuffix, "The suffix array should contain the last 3 elements of the original array.")
    }

    func testSuffixArrayWithZero() {
        let array = [1, 2, 3, 4, 5]
        let expectedSuffix = [Int]()
        let suffix = array.suffixArray(0)

        XCTAssertEqual(suffix, expectedSuffix, "The suffix array should be empty because the parameter is 0.")
    }

    func testSuffixArrayWithGreaterThanCount() {
        let array = [1, 2, 3, 4, 5]
        let expectedSuffix = [1, 2, 3, 4, 5]
        let suffix = array.suffixArray(10)

        XCTAssertEqual(suffix, expectedSuffix, "The suffix array should contain all the elements of the original array because the parameter is greater than the count of the array.")
    }

    func testSuffixArrayWithEqualCount() {
        let array = [1, 2, 3, 4, 5]
        let expectedSuffix = [1, 2, 3, 4, 5]
        let suffix = array.suffixArray(5)

        XCTAssertEqual(suffix, expectedSuffix, "The suffix array should contain all the elements of the original array because the parameter is equal to the count of the array.")
    }

    func testAllIndices() {
        let numbers = [1, 2, 3, 1, 4, 5, 1]
        let indicesOfOne = numbers.allIndices(of: 1)
        XCTAssertEqual(indicesOfOne, [0, 3, 6])

        let indicesOfTwo = numbers.allIndices(of: 2)
        XCTAssertEqual(indicesOfTwo, [1])

        let indicesOfThree = numbers.allIndices(of: 3)
        XCTAssertEqual(indicesOfThree, [2])

        let indicesOfFour = numbers.allIndices(of: 4)
        XCTAssertEqual(indicesOfFour, [4])

        let indicesOfFive = numbers.allIndices(of: 5)
        XCTAssertEqual(indicesOfFive, [5])

        let indicesOfNonExistentElement = numbers.allIndices(of: 10)
        XCTAssertEqual(indicesOfNonExistentElement, [])
    }

    func testAllIndicesWithEmptyArray() {
        let emptyArray: [Int] = []
        let indices = emptyArray.allIndices(of: 1)
        XCTAssertEqual(indices, [])
    }

    func testRemoveAll() {
        var array = [1, 2, 2, 3, 4, 2, 5]

        array.removeAll(of: 2)

        XCTAssertEqual(array, [1, 3, 4, 5], "The function should remove all instances of the specified element from the array.")
    }

    func testRemoveAllEmptyArray() {
        var array: [Int] = []

        array.removeAll(of: 1)

        XCTAssertEqual(array, [], "The function should not modify an empty array.")
    }

    func testRemoveAllNoMatchingElement() {
        var array = [1, 2, 3, 4, 5]

        array.removeAll(of: 6)

        XCTAssertEqual(array, [1, 2, 3, 4, 5], "The function should not modify the array if the specified element is not found.")
    }

    func testRemoveAllString() {
        var array = ["apple", "banana", "apple", "cherry", "grape"]

        array.removeAll(of: "apple")

        XCTAssertEqual(array, ["banana", "cherry", "grape"], "The function should remove all instances of the specified element from an array of strings.")
    }

    func testInsertElementAtIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 4, atIndex: 1)
        XCTAssertEqual(array, [1, 4, 2, 3])
    }

    func testInsertElementAtBeginning() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 0, atIndex: 0)
        XCTAssertEqual(array, [0, 1, 2, 3])
    }

    func testInsertElementAtEnd() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 4)
        XCTAssertEqual(array, [1, 2, 3, 4])
    }

    func testInsertElementInEmptyArray() {
        var array: [Int] = []
        array.insertOrRemove(element: 1)
        XCTAssertEqual(array, [1])
    }

    func testInsertExistingElement() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 2)
        XCTAssertEqual(array, [1, 3])
    }

    func testRemoveElementAtIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 2, atIndex: 1)
        XCTAssertEqual(array, [1, 3])
    }

    

    func testRemoveFirstOccurrence() {
        var array = [1, 2, 3, 2, 4]
        array.insertOrRemove(element: 2)
        XCTAssertEqual(array, [1, 3, 2, 4])
    }

    

    func testInsertElementAtNegativeIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 4, atIndex: -1)
        XCTAssertEqual(array, [1, 2, 3, 4])
    }

    func testInsertElementAtOutOfBoundsIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 4, atIndex: 10)
        XCTAssertEqual(array, [1, 2, 3, 4])
    }

    func testRemoveElementAtNegativeIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 2, atIndex: -1)
        XCTAssertEqual(array, [1, 3])
    }

    func testRemoveElementAtOutOfBoundsIndex() {
        var array = [1, 2, 3]
        array.insertOrRemove(element: 2, atIndex: 10)
        XCTAssertEqual(array, [1, 3])
    }

    static var allTests = [("testPositiveIndex", testPositiveIndex),
                           ("testNegativeIndex", testNegativeIndex),
                           ("testOutOfBoundsPositiveIndex", testOutOfBoundsPositiveIndex),
                           ("testOutOfBoundsNegativeIndex", testOutOfBoundsNegativeIndex),
                           ("testEmptyArray", testEmptyArray),
                           ("testJoinString", testJoinString),
                           ("testSuffixArrayWithPositiveNumber", testSuffixArrayWithPositiveNumber),
                           ("testSuffixArrayWithZero", testSuffixArrayWithZero),
                           ("testSuffixArrayWithGreaterThanCount", testSuffixArrayWithGreaterThanCount),
                           ("testSuffixArrayWithEqualCount", testSuffixArrayWithEqualCount)]
}
