//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 3/22/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension Text {
    
    
    /// An extension to the Text type that provides an initializer for creating a text view from a Double value.
    ///
    /// - Parameter dub: A Double value to be converted to a string and used as the text for the view.
    ///
    /// This extension adds an initializer to the Text type that takes a Double value as its argument. The str computed property is used to convert the Double value to a string, which is then passed to the default Text initializer to create the text view.

    /// The resulting Text view is then created and can be used to display the string representation of the Double value.
    init(_ dub: Double) {
        self.init(dub.str)
    }
    
    

    /// An initializer for the Text type that creates a text view from an array of String values.
    ///
    /// - Parameters:
    /// - arr: An array of String values to be combined into a single string and used as the text for the view.
    /// - sep: A separator string used to separate the values in the array. The default value is " ".
    ///
    /// This initializer takes an array of String values as its argument and creates a text view using the combined string created from the array's values. The joinString() method is called with the sep parameter to combine the String values into a single string.

    /// The resulting Text view is then created and can be used to display the combined string created from the array's values.
    init(_ arr: [String], sep: String = " ") {
        self.init(arr.joinString(sep))
    }
    
    
    
    
    /// An extension to the Text type that provides a method for adding spacing and another view to a text view.
    ///
    /// - Parameter otherView: A closure returning a View to be added to the text view with additional spacing.
    ///
    /// - Returns: A modified Text view with the original text and additional view separated by a spacer.
    ///
    /// This extension adds a method to the Text type that modifies the view to include an additional view separated from the original text by a spacer. The original text is included in the view with the self parameter.

    /// The otherView parameter is used to create a new View that displays the additional content. The two views and a spacer are then combined into an HStack view and returned as the result of this method.
    public func spacedOut<Content: View>(@ViewBuilder otherView: () -> Content) -> some View {
        HStack {
            self
            Spacer()
            otherView()
        }
    }

    /// An extension to the Text type that provides a method for adding spacing and additional text to a text view.
    ///
    /// - Parameter text: A String value to be added to the text view with additional spacing.
    ///
    /// - Returns: A modified Text view with the original text and additional text separated by a spacer.
    ///
    /// This extension adds a method to the Text type that modifies the view to include additional text separated from the original text by a spacer. The original text is included in the view with the self parameter.

    /// The text parameter is used to create a new Text view that displays the additional text. The two Text views and a spacer are then combined into an HStack view and returned as the result of this method.
    public func spacedOut(text: String) -> some View {
        HStack {
            self
            Spacer()
            Text(text)
        }
    }
    
    
    
    
}
