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
                    Image(systemName: "basket.fill")
                    
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
    }
}
