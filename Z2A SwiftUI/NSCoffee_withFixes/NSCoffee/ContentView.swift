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
    @AccessibilityFocusState var basketButtonFocus
    
    var body: some View {
        NavigationStack {
            List {
                Section("Coffees") {
                    ForEach(drinks.coffees, id: \.self) { coffee in
                        DrinkTableRow(drink: coffee, basket: basket)
                    }
                }
                
                Section("Hot Drinks") {
                    ForEach(drinks.hotDrinks, id: \.self) { drink in
                        DrinkTableRow(drink: drink, basket: basket)
                    }
                }
                
                Section("Cold Drinks") {
                    ForEach(drinks.coldDrinks, id: \.self) { drink in
                        DrinkTableRow(drink: drink, basket: basket)
                    }
                }
            }
            
            /* Fix: Using the SwiftUI Sheet API allows
             us to get the expected behaviour when the
             modal basket appears. It also means we have
             expected behaviour for transparency and
             reduce motion.
             */
            .sheet(isPresented: $showBasket) {
                BasketView(basket: basket, showBasket: $showBasket)
            }
            
            .navigationTitle("NSCoffee")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    BasketButton(showBasket: $showBasket, basket: basket)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
