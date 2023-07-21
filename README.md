# VinPackage 
VinPackage is a Swift package that provides a set of extensions for commonly used types in iOS development. These extensions make it easier to perform various operations, such as formatting numbers and dates, handling colors, and working with arrays and strings.

## Table of Contents
- [VinPackage](#vinpackage)
  - [Installation Options](#installation-options)
    - [As a dependency](#as-a-dependency)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
  - [Usage](#usage)
    - [Color](#color)
    - [Date](#date)
    - [Double](#double)
    - [Array](#array)
    - [Int](#int)
    - [String](#string)
  - [Contributing](#contributing)




## Installation Options
### As a dependency
To use VinPackage in your project, simply add it as a dependency in your Package.swift file:
```swift
dependencies: [
    .package(url: "https://github.com/vdeaugustine/VinPackage.git", from: "1.0.0")
]
```
### Swift Package Manager
You can easily add VinPackage to your Xcode project by using the Swift Package Manager. Follow these steps:

1. Open your Xcode project.
2. Click on the File menu and select Swift Packages, then Add Package Dependency.
3. Enter https://github.com/vdeaugustine/VinPackage.git as the package repository URL.
4. Choose the latest version you want to use.
5. Click Next and then Finish.

### Manually
You can also add VinPackage manually to your Xcode project. Follow these steps:

1. Clone the VinPackage repository to your local machine.
2. Open your Xcode project.
3. Drag the VinPackage folder from the cloned repository into your project navigator.
4. In the "Add files to" dialog, make sure your project target is selected and click Add.

## Usage
VinPackage provides extensions and utilities in various categories, including:

### Color
- `random`: returns a random color
- `getLighterColorForGradient(_ increaseAmount: CGFloat? = nil) -> Color:` returns a lighter color, useful for creating gradients
### Date
- `secondsFormatted:` formats a given number of seconds into a string representation that includes hours, minutes, and/or seconds
### Double
- `money`: formats a double as a monetary value
- `moneyExtended(decimalPlaces: Int = 4) -> String:` formats a double as a monetary value with an extended decimal format
- `str`: returns a string representation of the double
- `roundTo(places: Int) -> Double`: rounds the double to the specified number of decimal places
### Array
- `intersection(_ other: [Element]) -> [Element]`: returns an array containing the elements that are common to both the array and the given array
### Int
- `withSuffix: String`: returns the integer with an appropriate English suffix (e.g. "1st", "2nd", "3rd", "4th")
### String
- `getDoubleFromMoney() -> Double?`: extracts a double value from a string representing a monetary value
- `makeMoney(makeCents: Bool) -> String`: formats a string as a monetary value with or without cents
- `prefixArray(_ num: Int) -> [Element]:` returns the first num elements of the array
- `suffixArray(_ num: Int) -> [Element]:` returns the last num elements of the array
- `removingWhiteSpaces() -> String`: removes all white space characters from the string
- `join(with otherStrings: [String], _ separator: String = " ") -> String`: joins the string with one or more other strings using the specified separator

## Contributing
Contributions to VinPackage are welcome! If you find a bug, have an idea for a new feature, or just want to improve the code or documentation, feel free to open a pull request.
