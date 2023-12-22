//
//  File.swift
//  
//
//  Created by Vincent DeAugustine on 12/21/23.
//

import Foundation
import SwiftUI
import UIKit

public func openAppSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
    }
}
