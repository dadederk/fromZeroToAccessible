//
//  DrinkTableRow.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkTableRow: View {
    let drink: any Drink

    var body: some View {
        ZStack {

            HStack {
                DrinkTableImage(imageName: drink.imageName)
                    .padding(.trailing, 10)

                VStack(alignment: .leading) {
                    Text(drink.name)
                        .lineLimit(1)

                    Text(CurrencyFormatter.format(drink.basePrice))
                        .font(.system(size: 17.0))

                    Text("Add to cart")
                        .bold()
                        .padding(8)
                        .background(.blue)
                        .clipShape(.capsule)
                        .onTapGesture {
                            print("Added")
                        }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tint)
            }

            NavigationLink {
                DrinkDetail(drink: drink)

            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
}
