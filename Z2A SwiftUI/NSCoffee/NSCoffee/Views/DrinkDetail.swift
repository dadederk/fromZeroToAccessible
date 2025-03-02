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
                if let imageName = drink.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                } else {
                    Image(systemName: "cup.and.heat.waves.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }

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
