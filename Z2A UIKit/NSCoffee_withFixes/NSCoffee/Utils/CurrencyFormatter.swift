//
//  CurrencyFormatter.swift
//  NSCoffee
//
//  Created by Dani on 01/03/2025.
//

import Foundation

struct CurrencyFormatter {
    static func format(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: amount as NSNumber)!
    }
}
