//
//  Order.swift
//  NSCoffee
//
//  Created by Dani on 01/03/2025.
//

import SwiftUI

class Basket: ObservableObject {
    @Published var orders: [Order] = []

    var orderCount: Int {
        orders.reduce(into: 0) { $0 += $1.quantity }
    }

    func totalPrice() -> Double {
        return orders.reduce(into: 0.0) { $0 += $1.totalPrice() }
    }

    func add(_ drink: any Drink) {
        if let orderIndex = orders.firstIndex(where: { $0.drink.name == drink.name }) {
            let order = orders[orderIndex]
            let updatedOrder = Order(drink: order.drink, quantity: order.quantity + 1, extras: order.extras)

            orders[orderIndex] = updatedOrder

        } else {
            orders.append(Order(drink: drink))
        }
    }
}
