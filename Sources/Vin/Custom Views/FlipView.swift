//
//  SwiftUIView.swift
//  Vin
//
//  Created by Vincent DeAugustine on 3/30/25.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, *)
struct FlipView<FrontView: View, BackView: View>: View {
    @ViewBuilder let frontView: FrontView
    @ViewBuilder let backView: BackView

    @Binding var showBack: Bool
    
    var animation: Animation?

    var body: some View {
        ZStack {
            frontView
                .modifier(FlipOpacity(percentage: showBack ? 0 : 1))
                .rotation3DEffect(Angle.degrees(showBack ? 180 : 360),
                                  axis: (0, 1, 0),
                                  perspective: 0)
            backView
                .modifier(FlipOpacity(percentage: showBack ? 1 : 0))
                .rotation3DEffect(Angle.degrees(showBack ? 0 : 180),
                                  axis: (0, 1, 0),
                                  perspective: 0)
        }
        .conditionalModifier(animation != nil, { view in
            view.animation(animation!, value: showBack)
        })
        .makeButton {
            withAnimation {
                self.showBack.toggle()
            }
        }
    }
}

// MARK: - FlipOpacity
@available(iOS 14.0, macOS 11.0, tvOS 14.0, *)
private struct FlipOpacity: AnimatableModifier {
    var percentage: CGFloat = 0

    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }

    func body(content: Content) -> some View {
        content
            .opacity(Double(percentage.rounded()))
    }
}
