//
//  BasketRow.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketRow: View {
    let order: Order

    private var orderDetail: String {
        "\(order.quantity) x \(CurrencyFormatter.format(order.drink.basePrice)) = \(CurrencyFormatter.format(order.totalPrice))"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.drink.name)
                    .foregroundStyle(.white)

                Text(orderDetail)
                    .foregroundStyle(.white.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
