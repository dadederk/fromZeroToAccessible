//
//  RatingView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct RatingView: View {
    @State private var rating = 1

    var body: some View {
        HStack {
            ForEach(1..<6) { value in
                Button {
                    withAnimation {
                        rating = value
                    }

                } label: {
                    Image(systemName: value <= rating ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .containerRelativeFrame(.horizontal, count: 12, span: 2, spacing: 10)
                        .foregroundStyle(.tint)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)

        /* Fix: Grouping these buttons together as a single
         element for assistive technologies makes the control
         easier to understand and interact with
         */
        .accessibilityElement(children: .ignore)

        /* Fix: We need to add an accessible label to our new
         grouped control
         */
        .accessibilityLabel("Rating")

        /* Fix: And report the value in a meaningful way
         */
        .accessibilityValue("\(rating) thumb up")

        /* Fix: Hints are optional extra pieces of information
         that can help describe the action of unusual controls
         */
        .accessibilityHint("Rates your drink from 1 to 5 thumbs up")

        /* Fix: Adding the adjustable action allows assistive
         technologies to interact directly with the control
         */
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                guard rating < 5 else { return }
                rating += 1

            case .decrement:
                guard rating > 1 else { return }
                rating -= 1

            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview {
    RatingView()
}
