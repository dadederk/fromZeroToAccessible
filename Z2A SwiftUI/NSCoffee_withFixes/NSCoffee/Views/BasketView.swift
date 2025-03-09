//
//  BasketView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var basket: Basket
    @State var loading = false
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    @MainActor
    func purchase(success: Bool) {
        loading = false
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack {
                    if basket.isEmpty {
                        Text("Basket empty")
                    }

                    ForEach(basket.orders, id: \.self) {
                        BasketRow(order: $0)
                    }
                }
            }
            .padding(.bottom, 4)

            Spacer()

            Button {
                if !basket.isEmpty {
                    loading = true
                    Task {
                        let success = await basket.placeOrder()
                        purchase(success: success)
                    }
                }

            } label: {
                ZStack {
                    HStack {
                        if loading {
                            ProgressView()
                        }

                        Spacer()
                    }

                    Text("\(CurrencyFormatter.format(basket.totalPrice)) Buy")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .opacity(basket.isEmpty || loading ? 0.5 : 1.0)
        }

        /* Fix: This view will act as a modal view
         for assistive technologies. It avoids the
         cursor, or focus, to move to any sibling
         views.
         */
        .accessibilityAddTraits(.isModal)

        .padding()
        .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 0)
        .containerRelativeFrame(.vertical, count: 3, span: 2, spacing: 0)
        .background(

            /* Fix: Using semantic colors, instead of
             specifying the exact color, will lots
             of times make easier to have good color
             contrast ratios. And at the very least, you'll
             get support for Light/Dark modes, and Increase
             Contrast On/Off (in all four combinations), for
             free.
             */
            Color(UIColor.tertiarySystemBackground)

            /* Fix: When the user has enabled reduce transparency
             we'll respect the users choice and remove the
             transparency from the toast background
             */
                .opacity(reduceTransparency ? 1.0 : 0.90)
        )
        .cornerRadius(10)
        .transition(.scale(scale: 0, anchor: UnitPoint.topTrailing))

        /* Fix: Forcing the view's color scheme to dark
         allows us to keep the dark appearance for this
         overlay while still using semantic colors

         Note: Generally, apps shouldn't change between
         dark and light appearances within the app.
         but for subviews such as this, it can be acceptable
         */
        .environment(\.colorScheme, .dark)
    }
}
