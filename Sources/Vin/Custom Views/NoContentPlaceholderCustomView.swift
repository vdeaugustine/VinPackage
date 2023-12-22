//
//  SwiftUIView.swift
//  
//
//  Created by Vincent DeAugustine on 12/21/23.
//

import SwiftUI


@available(iOS 15.0, *)
public struct NoContentPlaceholderCustomView: View {
    // Dynamic Properties
    var title: String
    var subTitle: String
    var imageSystemName: String
    var backgroundColor: Color? = nil
    var buttonTitle: String? = nil
    var buttonColor: Color? = nil
    var onButtonTap: (() -> Void)? = nil

    private var background: Color {
        backgroundColor ?? UIColor.systemBackground.color
    }

    
    public var body: some View {
        VStack {
            Spacer()

            Image(systemName: imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 85)
                .foregroundColor(.gray)

            VStack(spacing: 14) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                Text(subTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }

            Spacer()
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            if let onButtonTap,
               let buttonTitle,
               let buttonColor {
                Button {
                    onButtonTap()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(buttonColor.getGradient())
                        Text(buttonTitle)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .frame(width: 135, height: 50)
                }
            }

        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            background
                .ignoresSafeArea()
        }
    }
}

//#Preview {
//    if #available(iOS 15.0, *) {
//        NoContentPlaceholderCustomView(title: "Testing", subTitle: "this is a test", imageSystemName: "photo")
//    } else {
//        // Fallback on earlier versions
//    }
//}
