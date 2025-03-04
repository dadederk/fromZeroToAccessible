//
//  Order.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import Foundation

typealias Extras = [(description: String, price: Double)]

class Order {
    let drink: any Drink
    var quantity: Int
    var extras: Extras?

    init(drink: any Drink, quantity: Int = 1, extras: Extras? = nil) {
        self.drink = drink
        self.quantity = quantity
        self.extras = extras
    }

    func totalPrice() -> Double {
        return Double(quantity) * drink.basePrice + totalExtrasPrice()
    }

    func totalExtrasPrice() -> Double {
        return extras?.reduce(into: 0.0) { $0 += $1.price } ?? 0.0
    }
}
