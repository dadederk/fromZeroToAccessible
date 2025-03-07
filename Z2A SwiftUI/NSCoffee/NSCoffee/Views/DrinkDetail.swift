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
    @State var toastMessage: String?

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                List {
                    ZStack {
                        DrinkTableImage(imageName: drink.imageName)

                        VStack {
                            Spacer()

                            Text(drink.description)
                                .padding()
                        }
                    }
                    .listRowInsets(.init(top: 0,
                                         leading: 0,
                                         bottom: 0,
                                         trailing: 0))

                    Section("Extra Shots") {
                        ExtraShotsView(shotPrice: drink.shotPrice, extras: $extras)
                    }

                    Section("Rate your drink") {
                        RatingView()
                    }

                    MilkTypeView()
                }
                .listStyle(.grouped)

                Button {
                    if let order = order {
                        basket.add(order)

                    } else {
                        basket.add(Order(drink: drink))
                    }

                    toastMessage = "\(drink.name) added to cart"

                } label: {
                    HStack {
                        Image(systemName: "cart.fill.badge.plus")
                            .padding(.trailing, 4)

                        VStack(alignment: .leading) {
                            Text("Add")

                            if let order = order {
                                Text(CurrencyFormatter.format(order.perDrinkPrice))

                            } else {
                                Text(CurrencyFormatter.format(drink.basePrice))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

            }
            .background(Color(UIColor.systemGroupedBackground))
            .onChange(of: extras) { oldValue, newValue in
                if newValue.count > 0 {
                    order = nil
                    order = Order(drink: drink, extras: extras)
                } else {
                    order = nil
                }
            }
            .navigationTitle(drink.name)

            VStack {
                ToastView(message: $toastMessage)

                Spacer()
            }
        }
    }
}
