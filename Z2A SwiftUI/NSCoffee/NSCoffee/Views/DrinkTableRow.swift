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
    @Binding var toastMessage: String?

    var body: some View {
        ZStack {
            HStack {
                DrinkTableImage(imageName: drink.imageName)
                    .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 10)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(drink.name)
                        .lineLimit(1)

                    Text(CurrencyFormatter.format(drink.basePrice))
                        .font(.system(size: 17.0))
                        .foregroundStyle(Color(UIColor.darkGray))

                    Button {
                        basket.add(Order(drink: drink))
                        toastMessage = "\(drink.name) added to cart"
                    } label: {
                        Text("Add to cart")
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tint)
            }

            NavigationLink {
                DrinkDetail(drink: drink, basket: basket, toastMessage: $toastMessage)

            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
}
