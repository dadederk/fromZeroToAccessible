//
//  Order.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import Foundation

class Order: ObservableObject, Hashable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.drink.name == rhs.drink.name &&
        lhs.extras == rhs.extras
    }

    let drink: any Drink
    var quantity: Int
    var extras: [Extra]?

    init(drink: any Drink, quantity: Int = 1, extras: [Extra]? = nil) {
        self.drink = drink
        self.quantity = quantity
        self.extras = extras
    }

    var totalPrice: Double {
        Double(quantity) * perDrinkPrice
    }

    var perDrinkPrice: Double {
        drink.basePrice + totalExtrasPrice
    }

    private var totalExtrasPrice: Double {
        extras?.reduce(into: 0.0) { $0 += ($1.price * Double($1.quantity)) } ?? 0.0
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(drink.name)
    }
}
