@testable import Vin
import XCTest

// final class VinTests: XCTestCase {
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//        XCTAssertEqual(Vin().text, "Hello, World!")
//    }
// }

@available(iOS 13.0, *)
class DateTests: XCTestCase {
    // This function is a unit test for the `getNextWeekdays()` function.
    func testGetNextWeekdays1() {
        // Call the `getNextWeekdays()` function to get the next 5 weekdays.
        let weekdays = Date.getNextWeekdays(count: 5)

        // Check that the function returned an array with 5 elements.
        XCTAssertEqual(weekdays.count, 5, "The returned array should have 5 elements.")

        // Iterate over each element in the array.
        for i in 0 ..< weekdays.count {
            // Get the date and weekday component of the current element.
            let date = weekdays[i]
            let weekday = Calendar.current.component(.weekday, from: date)

            // Check that the weekday falls between Monday (2) and Friday (6).
            XCTAssertTrue(weekday >= 2 && weekday <= 6, "The returned array should only contain weekdays.")

            // If the current element is not the last element in the array.
            if i < weekdays.count - 1 {
                // Get the next date in the array.
                let nextDate = weekdays[i + 1]
                // Check that the current date is earlier than the next date.
                XCTAssertTrue(date < nextDate, "The returned array should be in ascending order.")
            }
        }
    }

    // This function is a unit test for the `getNextWeekdays()` function.
    func testGetNextWeekdays2() {
        // Create an instance of the Gregorian calendar.
        let calendar = Calendar(identifier: .gregorian)

        // Call the `getNextWeekdays()` function to get the next 10 weekdays.
        let weekdays = Date.getNextWeekdays(count: 10)

        // Check that the function returned the correct number of weekdays (10 in this case).
        XCTAssertEqual(weekdays.count, 10, "Should return the correct number of weekdays.")

        // Iterate over each weekday returned by the `getNextWeekdays()` function.
        for date in weekdays {
            // Get the weekday component of the date.
            let weekday = calendar.component(.weekday, from: date)
            // Check that the weekday is between Monday (2) and Friday (6).
            XCTAssertTrue(weekday >= 2 && weekday <= 6, "Returned date should be a weekday (Monday to Friday).")
        }
    }

    func testGetPreviousWeekdays() {
        // Get an array of the previous 5 weekdays
        let weekdays = Date.getPreviousWeekdays(count: 5)

        // Assert that the array contains 5 elements
        XCTAssert(weekdays.count == 5, "Should return 5 weekdays")

        // Loop through each weekday and check that it is not a weekend day
        let calendar = Calendar.current
        let weekdaySymbols = calendar.weekdaySymbols
        for i in 0 ..< weekdays.count {
            let weekdayIndex = calendar.component(.weekday, from: weekdays[i]) - 1
            let weekdayName = weekdaySymbols[weekdayIndex]
            XCTAssert(weekdayName != "Saturday" && weekdayName != "Sunday", "Should not include weekends")
        }

        // Check that the array does not include today's date
        let today = Date()
        let oldestWeekday = weekdays.last!
        XCTAssert(calendar.isDate(oldestWeekday, inSameDayAs: today) == false, "Should not include today")

        // Check that the array includes a day before today's date
        let latestWeekday = weekdays.first!
        XCTAssert(calendar.isDate(latestWeekday, inSameDayAs: today.addDays(-1)) == true, "First item should be the most previous weekday")
    }

    func testIsWeekdayForWeekdayDate() {
        // Test that a weekday date returns true.
        let date = Date(fromString: "02/02/2022")! // February 2, 2022, which is a Wednesday
        XCTAssertTrue(Date.isWeekday(date), date.getFormattedDate(format: .shortWeekdayFullDayMonthYear))
    }

    func testIsWeekdayForWeekendDate() {
        // Test that a weekend date returns false.
        let date = Date(fromString: "02/05/2022")! // February 5, 2022, which is a Saturday
        XCTAssertFalse(Date.isWeekday(date), date.getFormattedDate(format: .shortWeekdayFullDayMonthYear))
    }

    func testIsWeekdayForLeapYearDate() {
        // Test that a date in a leap year returns true.
        let date = Date(fromString: "02/29/2020")! // February 29, 2020, which is a Saturday
        XCTAssertFalse(Date.isWeekday(date), date.getFormattedDate(format: .shortWeekdayFullDayMonthYear))
    }

    func testIsWeekdayForNonLeapYearDate() {
        // Test that a date not in a leap year returns true.
        let date = Date(fromString: "02/28/2021")! // February 28, 2021, which is a Sunday
        XCTAssertFalse(Date.isWeekday(date), date.getFormattedDate(format: .shortWeekdayFullDayMonthYear))
    }

    func testUTCToDate() {
        // Test a valid UTC string
        let validDateString = "2023-06-13T00:07:02.054Z"
        let convertedDate = Date.UTCToDate(validDateString)!

        XCTAssertEqual(convertedDate.toUTC(), validDateString, "Unable to convert back")

        XCTAssertNotNil(convertedDate, "The date string was not converted correctly")

        // Test an invalid UTC string
        let invalidDateString = "2023-06-13T:07:02.054Z" // missing hour part
        XCTAssertNil(Date.UTCToDate(invalidDateString), "Invalid date string was converted")
    }

    func testTimeRangeString_sameDay() {
        let startTime = Date.getThisTime(hour: 4, minute: 0)! // July 25, 2023, at 4:00 AM
        let endTime = Date.getThisTime(hour: 16, minute: 0)! // July 25, 2023, at 4:00 PM

        let result = Date.timeRangeString(start: startTime, end: endTime)
        XCTAssertEqual(result, "4:00 AM - 4:00 PM", "Expected time range format to be without AM/PM for start time when both dates are within the same day.")
    }
    
    func testTimeRangeString_sameDaySamePeriod() {
        let startTime = Date.getThisTime(hour: 4, minute: 0)! // July 25, 2023, at 4:00 AM
        let endTime = Date.getThisTime(hour: 6, minute: 0)! // July 25, 2023, at 4:00 PM

        let result = Date.timeRangeString(start: startTime, end: endTime)
        XCTAssertEqual(result, "4:00 - 6:00 AM", "Expected time range format to be without AM/PM for start time when both dates are within the same day.")
    }

    func testTimeRangeString_differentDays() {
        let startTime = Date.getThisTime(hour: 4, minute: 0)! // July 25, 2023, at 4:00 AM
        let endTime = Date.getThisTime(hour: 4, minute: 0)!.addDays(3) // July 27, 2023, at 4:00 AM

        let result = Date.timeRangeString(start: startTime, end: endTime)
        XCTAssertEqual(result, "4:00 AM - 4:00 AM", "Expected time range format to be with AM/PM for start time when dates are on different days.")
    }
}
