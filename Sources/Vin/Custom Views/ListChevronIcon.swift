//
//  ListChevronIcon.swift
//  Vin
//
//  Created by Vincent DeAugustine on 3/30/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct ListChevronIcon: View {
    var font: Font? = nil
    var body: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(Color(.systemGray2))
            .font(font ?? .footnote)
            .fontWeight(.semibold)
    }
}
