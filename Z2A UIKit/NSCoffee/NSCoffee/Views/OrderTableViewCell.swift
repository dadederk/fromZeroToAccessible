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
        drinkLabel.text = order.drink.name
        extrasLabel.text = "\(order.quantity) x \(order.drink.basePrice) = \(CurrencyFormatter.format(order.drink.basePrice * Double(order.quantity)))"
    }
}
