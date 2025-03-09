//
//  ExtraShotsView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct ExtraShotsView: View {
    let shotPrice: Double
    @State private var shots = Double(0)
    @Binding var extras: [Extra]
    @Environment(\.dynamicTypeSize.isAccessibilitySize) var accessibilitySize

    private var extraShotPrice: Double {
        shotPrice * Double(shots)
    }

    private var extraShotPriceText: Text {
        Text("+ \(CurrencyFormatter.format(extraShotPrice))")
    }

    private var shotControl: some View {
        Group {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    guard shots > 0 else { return }
                    shots -= 1
                    if shots == 0 {
                        extras = []
                    } else {
                        extras = [Extra(description: "Extra shot", price: shotPrice, quantity: Int(shots))]
                    }
                }
                .foregroundStyle(.tint)

            Text("numberShots.\(Int(shots))")

            Image(systemName: "plus.circle")
                .onTapGesture {
                    guard shots < 4 else { return }

                    shots += 1
                    extras = [Extra(description: "Extra shot", price: shotPrice, quantity: Int(shots))]
                }
                .foregroundStyle(.tint)
        }
    }

    var body: some View {
        /* Fix: At larger text sizes moving content
         stacked horizontally to being stacked
         vertically allows for improved readability
         */
        ViewThatFits {
            HStack {
                shotControl
                extraShotPriceText
            }

            VStack {
                HStack {
                    shotControl
                }

                extraShotPriceText
            }
        }

        /* Fix: An accessibility representation allows us to provide the
         behaviour of a standard view for assistive technologies. In this
         case, a slider
         */
        .accessibilityRepresentation {
            Slider(value: $shots, in: 0...4, step: 1)

            /* Fix: We still need to make some adjustments to provide
             the right information to assistive technology users. here
             we set the accessibility label and value appropriately.
             */
                .accessibilityLabel("Extra shots")
                .accessibilityValue("numberShots.\(Int(shots)), + \(CurrencyFormatter.format(extraShotPrice))")
        }
    }
}
