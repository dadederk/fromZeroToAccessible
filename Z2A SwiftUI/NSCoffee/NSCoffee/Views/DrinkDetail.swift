//
//  DrinkDetail.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkDetail: View {
    let drink: any Drink
    @State var order: Order?
    @ObservedObject var basket: Basket
    @State var extras = [Extra]()

    var body: some View {
        List {
            ZStack {
                DrinkTableImage(imageName: drink.imageName)

                VStack {
                    Spacer()

                    Text(drink.description)
                        .padding()
                }
            }

            Section("Extra Shots") {
                ExtraShotsView(shotPrice: drink.shotPrice, extras: $extras)
            }

            Section("Rate your drink") {
                RatingView()
            }

            MilkTypeView()
        }
        .listStyle(.grouped)
        .onChange(of: extras) { oldValue, newValue in
            if newValue.count > 0 {
                order = nil
                order = Order(drink: drink, extras: extras)
            } else {
                order = nil
            }
        }
        .navigationTitle(drink.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    if let order = order {
                        basket.add(order)

                    } else {
                        basket.add(Order(drink: drink))
                    }

                    // TODO: Add toast

                } label: {
                    HStack {
                        Image(systemName: "cart.fill.badge.plus")
                        VStack {
                            Text("Add")

                            if let order = order {
                                Text(CurrencyFormatter.format(order.perDrinkPrice))
                                
                            } else {
                                Text(CurrencyFormatter.format(drink.basePrice))
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
