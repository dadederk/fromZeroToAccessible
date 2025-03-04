//
//  ContentView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct ContentView: View {
    private var drinks = Drinks()
    @ObservedObject private var basket = Basket()
    @State private var showBasket = false
    @State var toastMessage: String?

    var body: some View {
        ZStack {
        NavigationStack {
                ZStack(alignment: .topTrailing) {
                    List {
                        Section("Coffees") {
                            ForEach(drinks.coffees, id: \.self) { coffee in
                                DrinkTableRow(drink: coffee, basket: basket, toastMessage: $toastMessage)
                            }
                        }

                        Section("Hot Drinks") {
                            ForEach(drinks.hotDrinks, id: \.self) { drink in
                                DrinkTableRow(drink: drink, basket: basket, toastMessage: $toastMessage)
                            }
                        }

                        Section("Cold Drinks") {
                            ForEach(drinks.coldDrinks, id: \.self) { drink in
                                DrinkTableRow(drink: drink, basket: basket, toastMessage: $toastMessage)
                            }
                        }
                    }

                    BasketOverlay(showBasket: $showBasket, basket: basket, toastMessage: $toastMessage)
                }
            .navigationTitle("NSCoffee")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    BasketButton(showBasket: $showBasket, basket: basket)
                }
            }
        }

            ToastView(message: $toastMessage)
        }
    }
}


#Preview {
    ContentView()
}
