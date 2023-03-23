//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI



@available(iOS 14.0, *)
extension GridItem {
    static public func flexibleItems(_ amount: Int) -> [GridItem] {
        (0 ..< amount).map { _ in GridItem(.flexible()) }
    }

    static public func fixedItems(_ amount: Int, size: CGFloat) -> [GridItem] {
        (0 ..< amount).map { _ in GridItem(.fixed(size)) }
    }
}