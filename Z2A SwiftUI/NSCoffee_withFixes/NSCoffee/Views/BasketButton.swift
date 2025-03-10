//
//  BasketButton.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketButton: View {
    @Binding var showBasket: Bool
    @ObservedObject var basket: Basket

    var body: some View {
            Button {
                withAnimation(Animation.bouncy(duration: 0.3, extraBounce: 0.2).delay(0)) {
                    showBasket.toggle()
                }
            } label: {
                ZStack(alignment: .topTrailing) {
                    
                    /* Fix: Using the same icon here as the
                     detail screen is important for consistency
                     */
                    Image(systemName: "cart.fill")

                    if basket.orderCount > 0 {
                        HStack(spacing: 0) {
                            Text("\(basket.orderCount)")
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
        /* Fix: The button here had no accessible label,
         this means that when the cart is empty iOS uses
         the system-provided label for the SFSymbol.
         When an item is in the cart the label is the number
         of items. This change in label is very confusing.
         Instead we'll set a fixed label describing the button,
         and provide the number of items as a value.
         */
            .accessibilityLabel("Cart")
            .accessibilityValue("\(basket.orderCount) item")

        /* Fix: By default the Large Content Viewer
         will show the button's icon. It is important
         to show the number of items in the cart too.
         */
            .accessibilityShowsLargeContentViewer {
                Image(systemName: "cart.fill")
                Text("Cart, \(basket.orderCount) item")
            }
    }
}
