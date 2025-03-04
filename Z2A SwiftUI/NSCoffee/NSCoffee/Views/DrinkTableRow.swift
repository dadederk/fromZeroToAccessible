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

                    Text("Add to cart")
                        .bold()
                        .padding(8)
                        .background(.blue)
                        .clipShape(.capsule)
                        .onTapGesture {
                            basket.add(Order(drink: drink))
                        }
                }
                
                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tint)
            }

            NavigationLink {
                DrinkDetail(drink: drink, basket: basket)

            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
}
