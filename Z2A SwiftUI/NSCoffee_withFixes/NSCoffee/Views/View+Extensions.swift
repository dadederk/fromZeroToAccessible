//
//  View+Extensions.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 09/03/2025.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
