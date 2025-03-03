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
        var totalPrice = order.drink.basePrice * Double(order.quantity)
        var extrasText = order.extras?
            .compactMap({ "\($0) x \(CurrencyFormatter.format($1))"})
            .joined(separator: " + ") ?? ""
        
        extrasText = "(\(extrasText))"
        totalPrice += order.extras?.reduce(0) { $0 + $1.1 } ?? 0
        drinkLabel.text = order.drink.name
        extrasLabel.text = "\(order.quantity) x \(CurrencyFormatter.format(order.drink.basePrice)) + \(extrasText) = \(CurrencyFormatter.format(totalPrice))"
    }
}
