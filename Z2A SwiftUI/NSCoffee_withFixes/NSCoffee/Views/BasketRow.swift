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
        let basePrice =  CurrencyFormatter.format(order.drink.basePrice)
        let totalPrice = CurrencyFormatter.format(order.totalPrice)
        let quantity = order.quantity
        let extras = order.extras?
            .compactMap({ CurrencyFormatter.format($0.price * Double($0.quantity)) })
            .joined(separator: " + ") ?? "£0.00"

        /* Fix: Using the correct unicode character here (multiply - ×,
         rather than the letter x) allows VoiceOver to correctly speak
         the meaning of this text
         */
        return "\(quantity) × \(basePrice) + (\(extras)) = \(totalPrice)"
    }

    private var extras: String {
        order.extras?
            .compactMap({ "\($0.quantity) x \($0.description)" })
            .joined(separator: ", ") ?? ""
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.drink.name)

                if !(order.extras?.isEmpty ?? true) {
                    Text(extras)
                }

                Text(orderDetail)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }

        /* Fix: Combining the views here into a single
         accessibility element simplifies navigation for
         VoiceOver users
         */
        .accessibilityElement(children: .combine)

        .padding(.vertical, 4)
    }
}
