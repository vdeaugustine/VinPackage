//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 1/9/24.
//

import Foundation
import CoreGraphics

public extension CGSize {
    func formattedString(_ precision: Int = 0) -> String {
        let width = self.width.simpleStr(precision, false)
        let height = self.height.simpleStr(precision, false)
        return (width + " x " + height)
    }
}
