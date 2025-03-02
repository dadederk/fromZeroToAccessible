//
//  DrinkDetail.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkDetail: View {
    let drink: any Drink
    @State private var milkExpanded = false
    @State private var selectedMilk = MilkOptions.dairy

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

            Section {
                if milkExpanded {
                    ForEach(MilkOptions.allCases, id: \.self) { milk in

                        HStack {
                            Text(milk.rawValue)

                            Spacer()

                            Image(systemName: selectedMilk == milk ? "checkmark.circle" : "circle")
                                .accessibilityHidden(true)
                        }
                        .onTapGesture {
                            selectedMilk = milk
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Type of Milk")

                    Image(systemName: "chevron.up")
                        .rotationEffect(.degrees(milkExpanded ? 180 : 0))
                }
                .onTapGesture {
                    withAnimation {
                        milkExpanded.toggle()
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle(drink.name)
    }
}
