//
//  BasketView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var basket: Basket
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    if basket.isEmpty {
                        Text("Basket empty")
                            .foregroundStyle(.white)
                    }

                    ForEach(basket.orders, id: \.self) {
                        BasketRow(order: $0)
                    }
                }
            }
            .padding(.bottom, 4)

                Spacer()

                Button{
                   // TODO: Something

                } label: {
                    Text("\(CurrencyFormatter.format(basket.totalPrice)) Buy")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(basket.isEmpty)
        }
        .padding()
        .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 0)
        .containerRelativeFrame(.vertical, count: 3, span: 2, spacing: 0)
        .background(
            Color(UIColor.darkGray)
                .opacity(0.95)
        )
        .cornerRadius(10)
        .transition(.scale(scale: 0, anchor: UnitPoint.topTrailing))
    }
}
