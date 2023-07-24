import Foundation
import SwiftUI

public struct Vin {
    public private(set) var text = "Hello, World!"

    public init() {
    }

    /**
       Retrieves the height of the status bar on the current device.

       This function will return the height of the status bar for the current key window if the application has an active scene. The status bar's height will only be retrieved for scenes in the foreground. If the application has no active scene or no key window, this function will return 0.

       - Important:
         This function is only available for iOS 13 and above. This is because it uses the `connectedScenes` and `statusBarManager` properties introduced in iOS 13.

       - Returns: The height of the status bar as a `CGFloat`. If no active scenes or key window are available, or the application is running on an OS version below iOS 13, the return value will be `0`.

       # Example
       ```swift
       let statusBarHeight = getStatusBarHeight()
       ```

       - Author: Vin
       - Version: 1.0
     */
    @available(iOS 13.0, *)
    public func getStatusBarHeight() -> CGFloat {
        let statusBarHeight = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first?
            .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
}
