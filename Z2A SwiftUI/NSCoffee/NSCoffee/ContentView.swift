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
            List {
                Section("Coffees") {
                    ForEach(drinks.coffees) { coffee in
                        DrinkTableRow(drink: coffee)
                    }
                }

                Section("Hot Drinks") {
                    ForEach(drinks.hotDrinks) { drink in
                        DrinkTableRow(drink: drink)
                    }
                }

                Section("Cold Drinks") {
                    ForEach(drinks.coldDrinks) { drink in
                        DrinkTableRow(drink: drink)
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
