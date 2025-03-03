//
//  DrinkDetail.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkDetail: View {
    let drink: any Drink

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
                ExtraShotsView(shotPrice: drink.shotPrice)
            }

            Section("Rate your drink") {
                RatingView()
            }

            MilkTypeView()
        }
        .listStyle(.grouped)
        .navigationTitle(drink.name)
    }
}
