//
//  DrinkTableRow.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkTableRow: View {
    let drink: any Drink
    @ObservedObject var basket: Basket
    @Environment(\.dynamicTypeSize.isAccessibilitySize) var accessibilitySize

    var body: some View {
        NavigationLink {
            DrinkDetail(drink: drink, basket: basket)

            /* Fix: Putting everything inside the label of
             the navigation link will automatically group
             everything for assistive technologies so the
             list of drinks is easier to navigate.
             */
        } label: {

            /* Fix: In this case, if the text size is one
             of the accessibility text sizes, we change
             the stack view from horizontal to vertical
             so the text can flow from side to side of the
             screen, improving readability
             */
            if accessibilitySize {
                VStack {
                    DrinkTableRowContent(drink: drink, basket: basket)
                }
            } else {
                HStack {
                    DrinkTableRowContent(drink: drink, basket: basket)
                }
            }
        }
        /* Fix: Because the cell is now an accessibility
         element, assistive technology won't be able to
         find any of its subviews, including the "Add
         to cart" button.
         */
        .accessibilityAction(named: "Add to cart") {
            basket.add(Order(drink: drink))
        }
        
        /* Fix: Voice Control users can say "Tap <name>"
         to interact with an accessibility element. The
         default <name> is the accessibility label. In
         this case it includes the price. It is easier
         to allow the user to just say "Tap Espresso",
         rather than "Tap Espresso, £2.00".

         Note: From iOS 18, <name> is also by default,
         the subset of words from the beginning of the
         accessibility label. So in this case, it is
         not strictly necessary for iOS 18+.
         */
        .accessibilityInputLabels(["\(drink.name)", "\(drink.name), \(CurrencyFormatter.format(drink.basePrice))"])
    }
}
