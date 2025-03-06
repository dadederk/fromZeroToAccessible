//
//  OrderTableViewCell.swift
//  NSCoffee
//
//  Created by Dani on 01/03/2025.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    static let identifier = String(describing: OrderTableViewCell.self)
    
    @IBOutlet private weak var drinkLabel: UILabel!
    @IBOutlet private weak var extrasLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withOrder order: Order) {
        let totalPriceText = CurrencyFormatter.format(order.totalPrice)
        let basePriceText = CurrencyFormatter.format(order.drink.basePrice)
        var extrasText = "\(CurrencyFormatter.format(0.0))"
        
        if let extras = order.extras {
            extrasText = extras
                .compactMap({ "\($0.description) \(CurrencyFormatter.format($0.price))"})
                .joined(separator: " + ")
        }
        
        extrasText = "(\(extrasText))"
        drinkLabel.text = order.drink.name
        extrasLabel.text = "\(order.quantity) x \(basePriceText) + \(extrasText) = \(totalPriceText)"
    }
}
