//
//  Extra.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import Foundation

class Extra: Equatable {
    static func == (lhs: Extra, rhs: Extra) -> Bool {
        lhs.description == rhs.description &&
        lhs.price == rhs.price &&
        lhs.quantity == rhs.quantity
    }

    let description: String
    let price: Double
    let quantity: Int

    init(description: String, price: Double, quantity: Int) {
        self.description = description
        self.price = price
        self.quantity = quantity
    }
}
