//
//  File.swift
//
//
//  Created by Vincent DeAugustine on 12/29/23.
//

import AVKit
import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Image {
    /// Creates a compressed `Image` from a given `UIImage`.
    ///
    /// This method compresses the provided `UIImage` to the specified quality level and returns a corresponding `Image` for use in SwiftUI. The quality parameter determines the level of compression, where `1.0` represents the highest quality (least compression) and `0.0` the lowest quality (most compression).
    ///
    /// - Parameters:
    ///   - uiImage: The `UIImage` to be compressed.
    ///   - quality: A `CGFloat` value between `0.0` and `1.0` representing the desired compression quality. Defaults to `0.5`.
    /// - Returns: An optional `Image` object. Returns `nil` if the compression process fails.
    ///
    /// The method first attempts to create a JPEG representation of the provided `UIImage` with the given compression quality. If this is successful, it then attempts to create a new `UIImage` from the compressed JPEG data. Finally, it converts this `UIImage` into a SwiftUI `Image`. If any of these steps fail, the method returns `nil`.
    ///
    /// This extension is available on iOS 13.0 and later.
    ///
    /// Usage Example:
    /// ```swift
    /// let uiImage = UIImage(named: "exampleImage")
    /// let compressedImage = Image.compressed(from: uiImage, quality: 0.3)
    /// ```
    ///
    static func compressed(from uiImage: UIImage, quality: CGFloat = 0.5) -> Image? {
        guard let data = uiImage.jpegData(compressionQuality: quality),
              let compressedUIImage = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: compressedUIImage)
    }
}
