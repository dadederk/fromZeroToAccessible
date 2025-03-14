//
//  Order.swift
//  NSCoffee
//
//  Created by Dani on 01/03/2025.
//

import SwiftUI

@MainActor
class Basket: ObservableObject {
    @Published var orders: [Order] = []

    var isEmpty: Bool {
        orders.isEmpty
    }

    var orderCount: Int {
        orders.reduce(into: 0) { $0 += $1.quantity }
    }

    var totalPrice: Double {
        orders.reduce(into: 0.0) { $0 += $1.totalPrice }
    }

    func placeOrder() async -> Bool {
        try? await Task.sleep(for: .seconds(0.5))
        orders.removeAll()
        return true
    }

    func add(_ order: Order) {
        if let orderIndex = orders.firstIndex(where: {
            $0.drink.name == order.drink.name &&
            $0.extras == order.extras
        }) {
            let existingOrder = orders[orderIndex]
            order.quantity = existingOrder.quantity + 1

            orders[orderIndex] = order

        } else {
            orders.append(order)
        }
    }
}
