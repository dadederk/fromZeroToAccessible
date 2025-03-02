//
//  ContentView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct ContentView: View {
    private var drinks = Drinks()

    var body: some View {
        NavigationStack {
            List(drinks.coffees) { drink in
                HStack {
                    DrinkImage(imageName: drink.imageName)
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
                }
            }
            .navigationTitle("NSCoffee")
        }
    }
}


#Preview {
    ContentView()
}
