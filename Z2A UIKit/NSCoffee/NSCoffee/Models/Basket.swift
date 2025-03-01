//
//  Order.swift
//  NSCoffee
//
//  Created by Dani on 01/03/2025.
//

final class Order {
    let drink: Drink
    var quantity: Int
    
    init(drink: Drink, quantity: Int = 1) {
        self.drink = drink
        self.quantity = quantity
    }
}

struct Basket {
    var orders: [Order] = []
}
