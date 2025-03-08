//
//  BasketView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var basket: Basket
    @Binding var toastMessage: String?
    @State var loading = false

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
                            .foregroundStyle(.white)
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
        .padding()
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
