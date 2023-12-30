//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 12/29/23.
//

import Foundation
import SwiftUI
import AVKit

import UIKit

public extension UIImage {
    /// Compresses the image to a specified quality level.
    ///
    /// This method attempts to reduce the size of the image by compressing it to the specified quality level. The quality parameter determines the level of compression applied, where `1.0` represents the highest quality (least compression) and `0.0` the lowest quality (most compression).
    ///
    /// - Parameter quality: A `CGFloat` value between `0.0` and `1.0` representing the desired compression quality. Defaults to `0.5`.
    /// - Returns: An optional `UIImage` object. Returns `nil` if the compression process fails.
    ///
    /// The method first attempts to create a JPEG representation of the image with the given compression quality. If successful, it then attempts to create a new `UIImage` from the compressed JPEG data. If either of these steps fails, the method returns `nil`.
    ///
    /// Usage:
    /// ```swift
    /// let originalImage = UIImage(named: "example")
    /// let compressedImage = originalImage?.compressed(quality: 0.3)
    /// ```
    ///
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality),
              let compressedImage = UIImage(data: data) else {
            return nil
        }
        return compressedImage
    }
}


