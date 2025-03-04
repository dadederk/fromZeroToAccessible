//
//  BasketOverlay.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketOverlay: View {
    @Binding var showBasket: Bool
    @ObservedObject var basket: Basket

    var body: some View {
        if showBasket {
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .background(
                Color(UIColor.darkGray)
                    .opacity(0.5)
            )
            .onTapGesture {
                withAnimation(Animation.bouncy(duration: 0.3, extraBounce: 0.2).delay(0)) {
                    showBasket.toggle()
                }
            }
        }

        if showBasket {
            BasketView(basket: basket)
        }
    }
}
