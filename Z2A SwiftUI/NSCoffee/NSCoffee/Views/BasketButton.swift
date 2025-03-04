//
//  BasketButton.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketButton: View {
    @Binding var showBasket: Bool

    var body: some View {
            Button {
                withAnimation(Animation.bouncy(duration: 0.3, extraBounce: 0.2).delay(0)) {
                    showBasket.toggle()
                }
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "basket.fill")
                    HStack(spacing: 0) {
                        Text("1")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(.red)
                    .frame(height: 19)
                    .clipShape(Capsule())
                }
            }
    }
}
