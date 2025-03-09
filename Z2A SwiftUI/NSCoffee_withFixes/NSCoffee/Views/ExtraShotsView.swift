//
//  ExtraShotsView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct ExtraShotsView: View {
    let shotPrice: Double
    @State private var shots = 0
    @Binding var extras: [Extra]

    private var extraShotPrice: Double {
        shotPrice * Double(shots)
    }

    var body: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    guard shots > 0 else { return }

                    shots -= 1

                    if shots == 0 {
                        extras = []
                    } else {
                        extras = [Extra(description: "Extra shot", price: shotPrice, quantity: shots)]
                    }
                }
                .foregroundStyle(.tint)

            Text("numberShots.\(shots)")

            Image(systemName: "plus.circle")
                .onTapGesture {
                    guard shots < 4 else { return }

                    shots += 1
                    extras = [Extra(description: "Extra shot", price: shotPrice, quantity: shots)]
                }
                .foregroundStyle(.tint)

            Text("+ \(CurrencyFormatter.format(extraShotPrice))")
        }
    }
}
