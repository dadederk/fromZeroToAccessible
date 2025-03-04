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

    private var extraShotPrice: Double {
        shotPrice * Double(shots)
    }

    var body: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    guard shots > 0 else { return }
                    shots -= 1
                }
                .foregroundStyle(.tint)

            Text("numberShots.\(shots)")

            Image(systemName: "plus.circle")
                .onTapGesture {
                    guard shots < 4 else { return }
                    shots += 1
                }
                .foregroundStyle(.tint)

            Text("+ \(CurrencyFormatter.format(extraShotPrice))")
        }
    }
}
