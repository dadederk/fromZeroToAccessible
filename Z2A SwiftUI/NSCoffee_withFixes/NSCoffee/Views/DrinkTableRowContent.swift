//
//  DrinkTableRowContent.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 09/03/2025.
//

import SwiftUI

struct DrinkTableRowContent: View {
    let drink: any Drink
    @ObservedObject var basket: Basket
    @Environment(\.dynamicTypeSize.isAccessibilitySize) var accessibilitySize

    var body: some View {
        HStack {
            DrinkTableImage(imageName: drink.imageName)
                .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 10)
                .padding(.trailing, 10)

            if accessibilitySize {
                Spacer()
            }
        }

        HStack {
            VStack(alignment: .leading) {
                /* Fix: By removing a line limit the text
                 is allowed an unlimited number of lines to
                 scale as needed.
                 */
                Text(drink.name)

                Text(CurrencyFormatter.format(drink.basePrice))
                /* Fix: Instead of fixing the font size we
                 specify a preferred font for a text style,
                 that will adapt in size as per the user
                 preference.
                 */
                    .font(.callout)

                /* Fix: Using semantic colors, instead of
                 specifying the exact color, will lots
                 of times make easier to have good color
                 contrast ratios. And at the very least, you'll
                 get support for Light/Dark modes, and Increase
                 Contrast On/Off (in all four combinations), for
                 free.
                 */
                    .foregroundStyle(.secondary)

                Button {
                    basket.add(Order(drink: drink))
                } label: {
                        Text("Add to cart")
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

