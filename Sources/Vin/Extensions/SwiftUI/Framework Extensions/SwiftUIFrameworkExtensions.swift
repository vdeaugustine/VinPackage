//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
public extension GridItem {
    static func flexibleItems(_ amount: Int) -> [GridItem] {
        (0 ..< amount).map { _ in GridItem(.flexible()) }
    }

    static func fixedItems(_ amount: Int, size: CGFloat) -> [GridItem] {
        (0 ..< amount).map { _ in GridItem(.fixed(size)) }
    }
}

@available(iOS 13.0, *)
public extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
    
    /**
       Registers a closure to be executed when the value of the binding is updated **but only if** the *newValue* is *equal to* the *previous value*, and optionally a completion closure to be executed after the value is set.

       - Parameters:
            - closureForNoChange: A closure that takes the updated value as its parameter and is executed if the new value is equal to the current value of the binding.
            - completion: An optional closure to be executed after the value is set.

       - Returns: A new binding that wraps the original value.

       - Note: The closure `closureForNoChange` will only be executed if the new value is equal to the current value of the binding. The `completion` closure, if provided, will always be executed after the value is set.
    */
    
    func onUpdate(ifNoChange closureForNoChange: @escaping (Value) -> Void,
                  completion: (() -> Void)? = nil) -> Binding<Value> where Value: Equatable {
        Binding(get: { wrappedValue },
                set: {
                    if $0 == wrappedValue {
                        closureForNoChange($0)
                    }
                    wrappedValue = $0
                    completion?()
                })
    }
}
