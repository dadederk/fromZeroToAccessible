//
//  BasketView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Flat White")
                            .foregroundStyle(.white)
                        Text("1 x 3.7 = £3.70")
                            .foregroundStyle(.white.secondary)
                    }
                }

                Spacer()

                Button{
                    // do something

                } label: {
                    Text("£3.70 Buy")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
        }
        .containerRelativeFrame(.horizontal, count: 4, span: 3, spacing: 0)
        .containerRelativeFrame(.vertical, count: 3, span: 2, spacing: 0)
        .background(
            Color(UIColor.darkGray)
                .opacity(0.95)
        )
        .cornerRadius(10)
        .transition(.scale(scale: 0, anchor: UnitPoint.topTrailing))
    }
}
