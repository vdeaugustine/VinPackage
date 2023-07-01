//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 6/30/23.
//

import Foundation

public extension NumberFormatter {
    static func custom(decimalPlaces: Int? = nil,
                       minPlaces: Int? = nil,
                       maxPlaces: Int? = nil,
                       locale: Locale? = nil,
                       useGroupingSeparator: Bool = true,
                       groupingSeparator: String? = nil)
        -> NumberFormatter {
            
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
            
        if let decimalPlaces {
            formatter.minimumFractionDigits = decimalPlaces
            formatter.maximumFractionDigits = decimalPlaces
        }

        if let minPlaces {
            formatter.minimumFractionDigits = minPlaces
        }

        if let maxPlaces {
            formatter.maximumFractionDigits = maxPlaces
        }

        formatter.usesGroupingSeparator = useGroupingSeparator

        if let locale {
            formatter.locale = locale
        }

        if let separator = groupingSeparator {
            formatter.groupingSeparator = separator
        }
        return formatter
    }
}
