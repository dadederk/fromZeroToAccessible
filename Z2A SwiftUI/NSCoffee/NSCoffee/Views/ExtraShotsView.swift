//
//  ExtraShotsView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct ExtraShotsView: View {
    let shotPrice: Double
    @State private var shots = 1

    private var extraShotPrice: Double {
        (shotPrice * (Double(shots) - 1.0))
    }

    var body: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    guard shots > 1 else { return }
                    shots -= 1
                }
                .foregroundStyle(.tint)

            Text("numberShots.\(shots)")

            Image(systemName: "plus.circle")
                .onTapGesture {
                    guard shots < 5 else { return }
                    shots += 1
                }
                .foregroundStyle(.tint)

            Text("+ \(CurrencyFormatter.format(extraShotPrice))")
        }
    }
}
