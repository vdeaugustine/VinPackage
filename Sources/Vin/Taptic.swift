//
//  Taptic.swift
//  Vin
//
//  Created by Vincent DeAugustine on 9/26/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct Taptic {
    public static func light(intensity: CGFloat = 1) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: intensity)
    }

    public static func medium(intensity: CGFloat = 1) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: intensity)
    }

    public static func heavy(intensity: CGFloat = 1) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: intensity)
    }

    public static func rigid(intensity: CGFloat = 1) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: intensity)
    }

    public static func soft(intensity: CGFloat = 1) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred(intensity: intensity)
    }

    // You can also add other feedback types, like selection or notification
    public static func selectionChanged(intensity: CGFloat = 1) {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
    }

    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.notificationOccurred(type)
    }
}
